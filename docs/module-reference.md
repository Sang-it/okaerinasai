# Module Reference

Every source module, grouped by role. Each entry lists its path, purpose, key definitions, and how it connects to the rest. All UI modules `open! Core` and `open! Bonsai_web`; stateful ones also `open Bonsai.Let_syntax` (for `let%sub` / `let%arr` / `match%sub`).

**Convention:** `let view` = a pure `Vdom.Node.t` (no state). `let component` = a Bonsai component (`Vdom.Node.t Bonsai.t`), used when the module has state or reads the route.

---

## Entry & Routing

### `bin/main.ml`
The JS entry point. Boots Bonsai and mounts the root component:
```ocaml
let () = Bonsai_web.Start.start ~bind_to_element_with_id:"app" Portfolio.App.component
```
Compiled to `bin/main.bc.js`, then promoted to `static/main.bc.js`. Defined as an executable in `bin/dune` (modes `byte exe js`, libraries `portfolio bonsai.web core`).

### `lib/app.ml`
Root component and route dispatcher. `match%sub Route.value` picks the page component for the current URL, then wraps it: `<div><div class="page-box">[Nav.view; <main>[content]]</div>Footer.view</div>`. This is the top of the component tree; everything else hangs off it.
- **Depends on:** `Route`, and every page component (`Home`, `Blog_index`, `Blog_post`, `Project_detail_page`, `Contribution_detail_page`), plus `Nav`, `Footer`.

### `lib/route.ml`
Typed client-side routing. Core of navigation.
- `Url.t` — the route variant: `Home | Blog | Blog_post of string | Project of string | Contribution of string` (`[@@deriving typed_variants, sexp, equal]`).
- `parser_for_variant` — per-variant `uri_parsing` `Parser.t` mapping URL paths ↔ the variant (e.g. `Project` ⇒ prefix `["projects"]` + string slug from path).
- `url_var` / `value` — `Bonsai_web_ui_url_var` binding to the browser URL, with `~fallback` to `Home` on parse failure. `value` is the incremental route read by `app.ml`.
- `to_path : Url.t -> string` — variant → URL string.
- `set_effect ?how route` — programmatic nav (`` `Push``/`` `Replace``).
- `scroll_to_top` — `Vdom.Effect` scrolling the window to `(0,0)`.
- `link_attrs route` — `href` + an `on_click` that prevents default, navigates via the URL var, and scrolls to top. **Every internal link uses this** (no full-page reloads).
- **Consumed by:** `app.ml`, `nav.ml`, `footer.ml`, `ui.ml`, `project_card.ml`, `contributions.ml`, `blog_index.ml`, `blog_post.ml`, and both detail pages.

---

## Data

### `lib/data.ml`
The site's primary content store — plain OCaml values, no Bonsai. Home-page cards read directly from here.
- `Hero.value` / `Hero.sub` — name, title, summary, tagline.
- `about` — list of about-section paragraphs.
- `Contacts.value` — github / email / linkedin / CTA.
- `Project.t` + `Project.make` — project record (`name`, `description`, `language`, `url`, `featured`, `tags`, `created_at`); `projects` is the list of all projects. `find_project ~name` looks one up.
- `Skill_category.t` + `skills` — grouped skill lists.
- `Experience.t` + `experiences` — work timeline.
- `Contribution.t` (with nested `pr`) + `contributions` — open-source contributions.
- **Consumed by:** `hero.ml`, `about.ml`, `projects.ml`, `project_card.ml`, `skills.ml`, `experience.ml`, `contributions.ml`, `footer.ml`, and both detail pages.

### `lib/project_details.ml`
Rich per-project data for project **detail pages only** (the home cards use `data.ml`). Not Bonsai.
- `t` — `slug`, `overview`, `languages : (string*int) list` (name→bytes), `loc`, `area`, `use_cases`, `features`, `tech_stack`.
- `all` — the list; `find slug` / `has slug` — lookup by slug (**slug = the project `name` in `data.ml`**).
- `percentages langs` — bytes → rounded percentage per language (for the language bar).
- `pct_str p` — format a percentage, trimming a trailing `.0`.
- **Consumed by:** `project_card.ml` (to decide internal vs external link) and `project_detail_page.ml` (to render).

### `lib/sort.ml`
Sort-order enum. Not Bonsai.
- `t = Newest | Oldest` with hand-written `equal`, `sexp_of_t`, `t_of_sexp` (sexp is `newest`/`oldest`, used for `Local_storage` serialization).
- `toggle`, `label` ("Newest first"/"Oldest first"), `is_newest`.
- **Consumed by:** `ui.ml` (sort store/button) and the three sortable lists (`projects.ml`, `contributions.ml`, `blog_index.ml`).

---

## Shared UI

### `lib/ui.ml`
Reusable view helpers and the sort-store factory. The most-reused module in `lib/`.
- `external_link_attrs ~href` / `external_link` — `<a>` with `target=_blank rel=noopener noreferrer`.
- `back_link ~route label` — internal "← back" link.
- `scroll_to id` — `Vdom.Effect` that scrolls an element into view (double `requestAnimationFrame` so it fires after render).
- `nav_scroll_link ~id label` — nav link that routes Home then scrolls to a section anchor.
- `meta_item ~label ~value` — a labeled meta cell (used in detail meta rows).
- `section ~title children` — a `<section>` with an `<h2>` heading.
- `tags ts` / `detail_list items` — tag pills / bulleted list.
- `not_found ~tag ~class_ ~back ~title ~message` — shared "not found" block for detail pages.
- `make_sort_store ~unique_id` — creates a `Bonsai_web.Persistent_var` over `Sort.t` in `` `Local_storage`` (default `Newest`). Keys used: `sort-blog`, `sort-projects`, `sort-contributions`.
- `sort_button store sort` — button that toggles the persisted sort.
- **Consumed by:** nearly every page/section module.

### `lib/nav.ml`
Top navigation bar (`let view`). Logo linking Home, plus links: Projects/Skills/Experience (scroll-to-anchor via `Ui.nav_scroll_link`) and Blog (route link).

### `lib/footer.ml`
Site footer (`let view`). External links (GitHub/LinkedIn via `Ui.external_link_attrs`), email + Blog links, and a copyright line. `current_year` is read at runtime from JS `Date` (`Js_of_ocaml.Js.date_now`).

---

## Home sections

### `lib/home.ml`
The home page (`let component`). Composes the sections in order with dividers: `Hero.view`, `About.view`, `Projects.component`, `Contributions.component`, `Skills.view`, `Experience.view`. Uses `let%sub`/`let%arr` because Projects and Contributions are stateful (sortable).

### `lib/hero.ml`
Hero banner (`let view`) — greeting, name (split first/last for styling), tagline. Reads `Data.Hero`.

### `lib/about.ml`
About section (`let view`, anchor `id="about"`) — maps `Data.about` paragraphs to `<p>`s.

### `lib/projects.ml`
Projects section (`let component`, anchor `id="projects"`). Reads the persisted sort store (`Ui.make_sort_store ~unique_id:"sort-projects"`), sorts `Data.projects` by `created_at`, and renders a grid of `Project_card.view`, with a `Ui.sort_button`.

### `lib/project_card.ml`
A single project card (`let view`). `link_attrs` chooses the link target: **internal** detail route (`Route.Url.Project name`) when `Project_details.has name`, otherwise **external** to the GitHub `url`. Shows name, description, language, and an arrow.

### `lib/contributions.ml`
Contributions section (`let component`, anchor `id="contributions"`). Same sortable pattern as projects (`unique_id:"sort-contributions"`, sorted by `pr.merged_at`). `card` renders each contribution (project name, inline star SVG + count, language, PR badge/title/number) linking to the internal contribution detail route.

### `lib/skills.ml`
Skills section (`let view`, anchor `id="skills"`) — renders `Data.skills` categories as bordered tag groups.

### `lib/experience.ml`
Experience section (`let view`, anchor `id="experience"`) — renders `Data.experiences` as a timeline of role/company/date/description items.

---

## Detail & list pages

### `lib/blog_index.ml`
Blog listing page (`let component`, route `/blog`). Combines a persisted sort (`unique_id:"sort-blog"`) with an ephemeral search `Bonsai.state`.
- `subsequence ~query title` — case-insensitive subsequence fuzzy match.
- `filtered ~query ~newest` — filters `Posts_data.posts` by the query and sorts by `date`.
- `post_card` — a post row linking to `Route.Url.Blog_post slug`.
- Renders a search input + sort button, and handles the empty states ("No posts yet" vs "No posts matching …").
- **Depends on:** `Posts_data` (generated), `Sort`, `Ui`, `Route`.

### `lib/blog_post.ml`
Single blog post page (`let component slug`, route `/blog/<slug>`). Finds the post in `Posts_data.posts` by slug; renders the header (back link, title, date) and injects the **pre-rendered** post HTML via `Vdom.Node.inner_html` (the HTML was produced by `omd` at build time). Falls back to `not_found` if the slug is unknown.

### `lib/project_detail_page.ml`
Project detail page (`let component slug`, route `/projects/<slug>`). Looks up both `Data.find_project ~name:slug` and `Project_details.find slug`; if both exist, `render` shows the header, meta row (area/language/loc/created), overview, a **language bar + list** (from `Project_details.percentages`), features, use cases, tech-stack tags, and a GitHub link. Otherwise `not_found`.

### `lib/contribution_detail_page.ml`
Contribution detail page (`let component slug`, route `/contributions/<slug>`). Finds the contribution in `Data.contributions` by slug; `render` shows header, meta row (area/language/stars/merged), a Pull Request section (badge, linked title/number, description), overview, tech-stack tags, and a project link. `with_commas` formats the star count. Otherwise `not_found`.

---

## Blog build pipeline

### `posts/gen.ml`
Build-time codegen executable (plain OCaml — **not** Bonsai; only depends on `omd`). Reads every `*.md` in a directory (default `.`), parses the `---`-delimited frontmatter (`title`, `date`, `description`), converts the Markdown body to HTML with `Omd.to_html (Omd.of_string body)`, and prints an OCaml module to stdout defining `type t = { slug; title; date; description; html }` and `let posts = [ … ]`. The `slug` is the filename minus `.md`.

### `posts/posts_data.ml` (generated — do not edit)
The output of `gen.ml`, captured by a dune `rule` in `posts/dune` (`with-stdout-to posts_data.ml (run ./gen.exe .)`) and exposed as the `posts_data` library. Regenerated on every build from the `.md` files. Consumed by `blog_index.ml` and `blog_post.ml`.

### `posts/dune`
Declares three things: the `gen` executable (module `gen`, lib `omd`), the `rule` that runs it over `*.md` to produce `posts_data.ml`, and the `posts_data` library wrapping that generated module.

---

## Build config (not source, but part of ownership)

| File | Role |
| --- | --- |
| `dune-project` | `(lang dune 3.17)`. |
| `dune` (root) | `release` profile: js_of_ocaml `whole_program` + `--opt 3`. |
| `bin/dune` | `main` executable, modes `byte exe js`, libs `portfolio bonsai.web core`. |
| `lib/dune` | `portfolio` library; libs incl. `bonsai.*`, `posts_data`, `virtual_dom`, `js_of_ocaml`; ppxes `ppx_jane ppx_typed_fields bonsai.ppx_bonsai js_of_ocaml-ppx`. |
| `static/dune` | `rule` promoting `../bin/main.bc.js` → `static/main.bc.js` (`promote (until-clean)`). |
| `.ocamlformat` | Formatter config for `dune fmt`. |
| `.githooks/pre-commit` | Release-builds and verifies the committed bundle matches source. |
