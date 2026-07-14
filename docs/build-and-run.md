# Build & Run

## Prerequisites

This is an **OCaml + dune** project (no Node/npm). You need an OCaml toolchain via [opam](https://opam.ocaml.org/):

- **opam** and an OCaml switch, with the environment loaded:
  ```sh
  eval "$(opam env)"
  ```
  Every `dune`/`just` command below assumes this has been run in the current shell. The pre-commit hook runs it too, but interactive commands won't.
- **dune** `>= 3.17` (declared in `dune-project`).
- **[just](https://github.com/casey/just)** — the command runner for the `justfile` recipes (optional; you can run the raw `dune` commands instead).
- **python3** — only for the local dev server (`serve.py`).

### opam libraries

Install into your switch (names as used in the `dune` files):

- `bonsai` — provides `bonsai`, `bonsai.web`, `bonsai.web_ui_url_var`, `bonsai.uri_parsing`, and the `bonsai.ppx_bonsai` preprocessor
- `core` — Jane Street stdlib
- `virtual_dom`
- `js_of_ocaml` + `js_of_ocaml-ppx` (`js_of_ocaml-ppx` for the preprocessor)
- `omd` — Markdown → HTML (used by the blog codegen)
- `ppx_jane`, `ppx_typed_fields` — preprocessors used across `lib/`

Roughly: `opam install dune bonsai core virtual_dom js_of_ocaml js_of_ocaml-ppx omd ppx_jane ppx_typed_fields`. (Bonsai/`ppx_bonsai` come from Jane Street's package set; use the opam repository that ships them.)

## Commands

All recipes live in the [`justfile`](../justfile). Each maps to a raw `dune` command:

| `just` recipe | Raw command | Purpose |
| --- | --- | --- |
| `just build` | `dune build static/main.bc.js` | Dev build of the JS bundle. |
| `just release` | `dune build --profile release static/main.bc.js` | Optimized build (whole-program, `--opt 3`). This is what the pre-commit hook runs. |
| `just watch` | `dune build -w static/main.bc.js` | Rebuild on file change. |
| `just serve` | `python3 serve.py 8099` | Local static server → http://localhost:8099/. |
| `just fmt` | `dune fmt` | Format all OCaml (config in `.ocamlformat`). |
| `just check` | `dune build` | Typecheck / compile everything. |
| `just clean` | `dune clean` | Remove `_build/`. |

> The root [`dune`](../dune) file configures the `release` profile: `js_of_ocaml` in `whole_program` compilation mode with `--opt 3`.

## Recommended dev loop

Two terminals (both with `eval "$(opam env)"` run first):

```sh
# Terminal 1 — rebuild the bundle whenever a source file changes
just watch

# Terminal 2 — serve static/ with SPA fallback
just serve
# → open http://localhost:8099/
```

Edit an `.ml`/`.md`/`.css` file → `just watch` rebuilds `static/main.bc.js` → refresh the browser.

### How `serve.py` behaves

`serve.py` (default port 8099) serves the `static/` directory with two conveniences:

- **Fresh-bundle preference:** for `/main.bc.js` it serves `_build/default/bin/main.bc.js` if that exists and is non-empty (i.e. what `just watch` just built), otherwise it falls back to the committed `static/main.bc.js`. So during development you see the freshly built bundle without re-promoting it.
- **SPA fallback:** any path that isn't a real file/dir is served `index.html`, so client-side routes like `/blog`, `/projects/wave`, `/contributions/rmpc` load correctly on direct navigation/refresh.
- On startup it prints the bundle path and size, and **warns loudly if the bundle is missing/empty** (the page would render blank — build it first).

## Committing changes — the bundle must stay in sync

`static/main.bc.js` (~965 KB) is **committed to git**. The [`.githooks/pre-commit`](../.githooks/pre-commit) hook enforces that it matches the source:

1. Loads `opam env` and checks `dune` is on `PATH` (fails with guidance if not).
2. Runs `dune build --profile release static/main.bc.js`.
3. Compares the freshly built bundle's `git hash-object` against the staged one.
4. If they differ, it **rejects the commit** and tells you to `git add static/main.bc.js` and retry.

The hook is active in this repo (`git config core.hooksPath` → `.githooks`). If you clone fresh and the hook doesn't run, enable it with:
```sh
git config core.hooksPath .githooks
```

**Practical rule:** after changing any OCaml or Markdown source, run `just release` (or let the hook do it), then `git add static/main.bc.js` alongside your source changes before committing.
