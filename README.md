# okaerinasai — Bonsai (OCaml) port

A port of the SvelteKit portfolio (in the parent directory) to **Jane Street's
Bonsai** framework, compiled to JavaScript with `js_of_ocaml`. It is a
client-rendered single-page app: one `index.html` loads a compiled JS bundle
that renders everything on the client.

## Layout
```
dune-project
bin/    main.ml        # Bonsai_web.Start.start App.component (entry point)
lib/    data.ml        # content ported from ../src/lib/data/*.ts (single source)
        route.ml       # Url.t + typed-variant parser + url_var + link/scroll helpers
        ui.ml          # shared view helpers (links, sections, back-link, sort button…)
        sort.ml        # Newest|Oldest, sexp-serialized to "newest"/"oldest"
        app.ml         # match%sub router + shared shell (Nav / main / Footer)
        home.ml        # the 6-section homepage stack
        blog_index.ml blog_post.ml                    # blog pages
        project_details.ml project_detail_page.ml     # /projects/:slug (extras + page)
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
