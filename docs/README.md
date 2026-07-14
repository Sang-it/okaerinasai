# Developer Documentation

Onboarding docs for **okaerinasai** — Sangit Manandhar's personal portfolio site. Read these to fully own the project.

> [!WARNING]
> **Ignore any tooling that claims this is a SvelteKit/Svelte/Vite/npm project.**
> Cached metadata (e.g. `.omc/project-memory.json`, some AI project-memory banners) is **stale** — it predates the port to Bonsai. The real stack is **OCaml + Bonsai compiled to JavaScript via js_of_ocaml**. There is no `package.json`, no `.svelte` files, and no Node/npm toolchain anywhere in this repo. When in doubt, trust the source and these docs.

## What this is

A **client-rendered single-page app (SPA)** portfolio: a home page (hero, about, projects, contributions, skills, experience), a technical blog, and detail pages for individual projects and open-source contributions. No backend — all content is either hardcoded in OCaml or compiled in from Markdown at build time, then shipped as one JavaScript bundle.

## The docs

| Doc | What's in it |
| --- | --- |
| [architecture.md](./architecture.md) | Big picture: entry point → routing → components → render, the build-time blog pipeline, state/persistence, and a full render walkthrough. Start here. |
| [build-and-run.md](./build-and-run.md) | Prerequisites, every build/dev command, the local server, and the pre-commit bundle check. |
| [module-reference.md](./module-reference.md) | Every source module documented — purpose, key functions, dependencies, consumers. |
| [adding-content.md](./adding-content.md) | Task recipes: add a blog post, project, contribution, or route; edit hero/about/skills/etc. |

## 30-second orientation

- **Entry file:** `bin/main.ml` mounts `Portfolio.App.component` onto `<div id="app">` in `static/index.html`.
- **Language/framework:** OCaml + [Bonsai](https://github.com/janestreet/bonsai) (Jane Street's incremental UI framework), rendered via `virtual_dom`.
- **Build:** `dune` compiles OCaml → JS with `js_of_ocaml`, producing `static/main.bc.js` (committed to git).
- **Content:** hardcoded in `lib/data.ml` + `lib/project_details.ml`; blog posts are `posts/*.md` compiled to OCaml by `posts/gen.ml`.
- **Run locally:** `just watch` (rebuild on change) + `just serve` (→ http://localhost:8099/).
