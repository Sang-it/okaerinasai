# okaerinasai — Bonsai (OCaml) port

A port of the SvelteKit portfolio (in the parent directory) to **Jane Street's
Bonsai** framework, compiled to JavaScript with `js_of_ocaml`. It is a
client-rendered single-page app: one `index.html` loads a compiled JS bundle
that renders everything on the client.

## Status — full site ported (M1–M4)

**M1 — homepage.** Nav, Hero, About, Projects, Contributions, Skills,
Experience, Footer — original dark / monospace / sharp-corner design, with the
newest/oldest **sort toggles persisted to localStorage** (keys `sort-projects`,
`sort-contributions`, shared with the original app).

**M2 — client-side routing + blog.** History-backed SPA routing
(`bonsai.web_ui_url_var` + `bonsai.uri_parsing`) for `/`, `/blog`, and
`/blog/:slug`. The 15 markdown posts in `posts/*.md` are converted to HTML **at
build time** by `posts/gen.ml` (using `omd`) via a dune rule, embedded into the
`Posts_data` module, and rendered with `Vdom.Node.inner_html`. The blog index
has the same fuzzy subsequence **search** and persisted sort (`sort-blog`) as the
original. Deep-links and reloads work when the host serves `index.html` as a
fallback (see `serve.py`).

**M3 — project detail pages.** `/projects/:slug` for all 16 projects
(`project_details.ml`, ported from `project-details.ts`): meta row, a languages
bar whose segment widths come from `percentages` (same `round(bytes/total*1000)/10`
formula as the original `computePercentages`), Features / Use Cases / Tech Stack,
and a GitHub link. Project cards now link internally (SPA) when a detail entry
exists — as all 16 do.

**M4 — contribution detail pages.** `/contributions/:slug`
(`contribution_detail_page.ml`): meta row (with `toLocaleString`-style star
grouping, e.g. `2,550`), Pull Request section (state badge + linked title/number),
Overview, Tech Stack, and a GitHub link. Contribution cards now link internally
(SPA).

Every route from the original SvelteKit app is now covered: `/`, `/blog`,
`/blog/:slug`, `/projects/:slug`, `/contributions/:slug`.

Known gaps (all inherent to the client-rendered SPA choice, not regressions):
per-route `<title>`/OG meta tags aren't updated dynamically (the original set
them per page; social-preview crawlers can't run the JS anyway — this was the
accepted trade-off of the SPA approach), and the in-page nav anchors
(`/#projects` etc.) navigate to home without smooth-scrolling to the section.

## Prerequisites

Built and tested with an opam switch on **OCaml 5.2.0** and **Bonsai v0.16.0**:

```sh
opam switch create bonsai-port 5.2.0
eval $(opam env --switch=bonsai-port)
# system deps (gmp, libffi, openssl, pkg-config, zlib) are pulled via brew:
opam install bonsai omd js_of_ocaml js_of_ocaml-compiler js_of_ocaml-ppx dune \
  --confirm-level=unsafe-yes
```

> Note: on the public opam repository the whole framework ships as the single
> `bonsai` package (there is no separate `bonsai_web`/`ppx_html`/`ppx_css`).
> v0.16.0 uses the **proc** API (`Value.t` / `Computation.t` / `let%sub` /
> `let%arr`), which is what this code targets.

## Build & run

```sh
eval $(opam env)                                # any switch with bonsai + dune (default is fine)
dune build bin/main.bc.js                       # also runs posts/gen to embed the blog
python3 serve.py 8099                           # SPA server; open http://localhost:8099/
```

`serve.py` serves `/main.bc.js` **straight from `_build/default/bin/`**, so there
is no copy step to get wrong — and it prints the bundle size at startup, warning
loudly if it's missing or empty. (An empty `static/main.bc.js` is what makes the
page render blank with no console error: the browser loads a 0-byte script and
`#app` never fills in. If you do stage a copy, verify it's ~25 MB, not 0 bytes.)

`dune build` alone type-checks everything; `bin/main.bc.js` produces the browser
bundle (`js` mode is enabled in `bin/dune`). Use `serve.py` rather than a plain
static server so client-side routes (`/blog/:slug`, `/projects/:slug`) work on
deep-link and reload. Asset paths in `index.html` are absolute (`/main.bc.js`,
`/styles.css`) so they resolve from any route depth.

## Layout

```
dune-project
bin/    main.ml        # Bonsai_web.Start.start App.component (entry point)
lib/    data.ml        # content ported from ../src/lib/data/*.ts
        route.ml       # Url.t + typed-variant parser + url_var + link helpers
        app.ml         # match%sub router + shared shell (Nav / main / Footer)
        home.ml        # the 6-section homepage stack
        blog_index.ml blog_post.ml                    # blog pages
        project_details.ml project_detail_page.ml     # /projects/:slug (data + page)
        contribution_detail_page.ml                   # /contributions/:slug
        nav/hero/about/skills/experience/footer.ml   # section views
        projects.ml contributions.ml                 # stateful (sort + localStorage)
        project_card.ml
posts/  *.md           # the 15 blog posts (copied from ../src/content/blog)
        gen.ml dune    # build-time md -> HTML (omd), emits the Posts_data module
static/ index.html styles.css favicon.svg            # global CSS = ../src/app.css
                                                     #   + component styles, merged
serve.py               # static server with SPA index.html fallback
```
