# Architecture

## Overview

This is a **client-rendered SPA** written in OCaml with [Bonsai](https://github.com/janestreet/bonsai) and compiled to JavaScript by `js_of_ocaml`. There is no server-side rendering and no runtime data fetching — every piece of content is baked into the JS bundle at build time. The browser loads one HTML shell, one CSS file, and one ~965 KB JS bundle, and the whole site runs from there.

```
┌─────────────────────────────────────────────────────────────┐
│ Browser                                                       │
│                                                               │
│  static/index.html  ──loads──►  /styles.css                   │
│        │                        /main.bc.js                   │
│        │                             │                        │
│        ▼                             ▼                        │
│   <div id="app">  ◄──mounts──  bin/main.ml                    │
│                                Bonsai_web.Start.start          │
│                                      │                        │
│                                      ▼                        │
│                            Portfolio.App.component            │
│                              (lib/app.ml)                     │
│                                      │                        │
│                    match on Route.value (lib/route.ml)        │
│         ┌────────────┬───────────┼────────────┬────────────┐ │
│         ▼            ▼           ▼            ▼            ▼   │
│      Home        Blog index  Blog post   Project detail Contrib│
│    (home.ml)   (blog_index) (blog_post) (project_...)  (...)  │
│         │                                                     │
│   Hero/About/Projects/Contributions/Skills/Experience        │
│                                                               │
│  Every page returns a Vdom.Node.t tree, wrapped by Nav+Footer │
└─────────────────────────────────────────────────────────────┘
```

## The layers

### 1. HTML shell — `static/index.html`
Static, hand-written. Sets the title/favicon, links `/styles.css`, defer-loads `/main.bc.js`, and provides the mount point `<div id="app"></div>`. Never generated.

### 2. Entry point — `bin/main.ml`
Three lines. Calls:
```ocaml
Bonsai_web.Start.start ~bind_to_element_with_id:"app" Portfolio.App.component
```
This boots the Bonsai runtime and mounts the root component into `#app`. `Portfolio` is the `lib/` library; `App` is `lib/app.ml`.

### 3. Root component + routing dispatch — `lib/app.ml`
The root component reads the current route (`Route.value`, an incremental `Bonsai` value) and `match%sub`es on it to pick the page component. It wraps the chosen page in a shared chrome: `Nav.view` at the top, `<main>` with the page content, and `Footer.view` at the bottom. When the route changes, the matched arm re-renders; the chrome stays.

### 4. Routing — `lib/route.ml`
URLs are **typed**, not stringly. `Route.Url.t` is a variant:

```ocaml
type t =
  | Home                    (* /                        *)
  | Blog                    (* /blog                    *)
  | Blog_post of string     (* /blog/<slug>             *)
  | Project of string       (* /projects/<slug>         *)
  | Contribution of string  (* /contributions/<slug>    *)
```

`uri_parsing` (`Parser.t` per variant via `[@@deriving typed_variants]`) maps paths ↔ the variant, and `Bonsai_web_ui_url_var` binds it to the browser URL bar with history/push-state. Unparseable URLs fall back to `Home`.

Navigation helpers in this module:
- `to_path route` — variant → URL string.
- `set_effect ?how route` — programmatic navigation (push/replace history).
- `link_attrs route` — attrs for an `<a>` that intercepts the click, prevents full-page nav, updates the URL var, and scrolls to top. This is how all internal links work (no page reloads).
- `scroll_to_top` — a `Vdom.Effect` used on navigation.

### 5. Page & section components — `lib/*.ml`
Each page is a Bonsai component returning a `Vdom.Node.t`. Two flavors:
- **`let view` (pure)** — static sections with no state: `hero.ml`, `about.ml`, `skills.ml`, `experience.ml`, `nav.ml`, `footer.ml`, `project_card.ml`.
- **`let component` (incremental)** — components with state or that read routes: `home.ml`, `projects.ml`, `contributions.ml`, `blog_index.ml`, `blog_post.ml`, `project_detail_page.ml`, `contribution_detail_page.ml`.

Shared building blocks (section wrappers, tag lists, meta rows, external links, sort buttons, "not found" blocks) live in `lib/ui.ml` and are reused across pages. See [module-reference.md](./module-reference.md) for each.

## Data model — content is compiled in

There is **no database and no API**. Content lives in source:

- **`lib/data.ml`** — the site's content record: `Hero`, `about` paragraphs, `Contacts`, the `projects` list (`Project.make`), `skills`, `experiences`, and `contributions`. Home-page cards read straight from here.
- **`lib/project_details.ml`** — the richer per-project data used only on project **detail** pages (overview, language byte-breakdown, LOC, use cases, features, tech stack). Keyed by `slug`, where `slug` equals the project's `name` in `data.ml`. A project only gets an internal detail page if it has a matching entry here (see `project_card.ml` → `Project_details.has`); otherwise its card links straight to GitHub.

### Blog pipeline (build-time codegen)

Blog content is **not** hardcoded in `.ml` — it's authored as Markdown and compiled in:

```
posts/*.md ──► posts/gen.ml (build-time exe) ──► posts/posts_data.ml ──► lib/blog_index.ml
   │              parses frontmatter,              (generated OCaml       lib/blog_post.ml
   │              runs omd (md→html)                module: posts list)
   └── frontmatter: title, date, description; body = Markdown
```

- Each `posts/<slug>.md` starts with `---` frontmatter (`title`, `date`, `description`) then Markdown body.
- `posts/gen.ml` is a small standalone OCaml executable. A dune `rule` runs it over `posts/*.md` and captures stdout into the generated module `posts_data.ml`, which exposes `type t` and `let posts : t list` (each with `slug`, `title`, `date`, `description`, and pre-rendered `html`). The `slug` is the filename without `.md`.
- `omd` converts the Markdown body to HTML **at build time**, so the runtime just injects pre-rendered HTML (via `Vdom.Node.inner_html`) — no Markdown parser ships to the browser.

Because everything is compiled in, **any content change requires a rebuild** (and re-committing the bundle — see below).

## State & persistence

The app is almost entirely stateless per-render, with two exceptions, both client-side:

- **Sort order** (Projects, Contributions, Blog) is persisted in browser `Local_storage` via `Bonsai_web.Persistent_var`. The factory `Ui.make_sort_store ~unique_id` (in `lib/ui.ml`) creates a store keyed by `sort-projects` / `sort-contributions` / `sort-blog`, defaulting to `Sort.Newest`. `Ui.sort_button` toggles it. The `Sort.t` type (`Newest | Oldest`) and its sexp serialization live in `lib/sort.ml`.
- **Blog search** uses ephemeral `Bonsai.state` (a text query) in `lib/blog_index.ml`, filtered with a hand-rolled subsequence fuzzy-match over post titles. Not persisted.

## Render walkthrough — navigating to `/projects/wave`

1. User clicks a project card whose link was built with `Route.link_attrs (Route.Url.Project "wave")` (`lib/project_card.ml`). The click handler prevents default, calls `Route.set_effect (Project "wave")` (push-state), and scrolls to top.
2. The URL var updates → `Route.value` becomes `Project "wave"`.
3. `lib/app.ml`'s `match%sub` selects `Project_detail_page.component "wave"`.
4. `lib/project_detail_page.ml` looks up both `Data.find_project ~name:"wave"` and `Project_details.find "wave"`. Both exist, so it calls `render project extras`.
5. `render` computes language percentages (`Project_details.percentages`), builds the language bar/list, meta row, overview, features, use-cases, tech-stack tags, and a GitHub link — all via `Ui.*` helpers — and returns a `Vdom.Node.t`.
6. `app.ml` wraps it with `Nav.view` and `Footer.view`; Bonsai diffs the vdom and patches the DOM. No network request occurs.

If the slug had no match in either table, `Project_detail_page.not_found` renders a "Project not found" block instead.

## Build & distribution model

- `dune` compiles the OCaml to `bin/main.bc.js` (js_of_ocaml). A dune `rule` in `static/dune` **promotes** (copies) that bundle to `static/main.bc.js`, which is **committed to git**.
- The `.githooks/pre-commit` hook does a release build and refuses the commit if the staged `static/main.bc.js` doesn't match a fresh build — keeping the committed bundle in sync with source. This hook is active (`core.hooksPath = .githooks`).
- Deployment is just static hosting of `static/` (any static host works; locally `serve.py` provides SPA fallback).

See [build-and-run.md](./build-and-run.md) for the commands.
