# Adding & Editing Content

All content is compiled into the JS bundle, so **every change here requires a rebuild** and re-committing `static/main.bc.js` (see [build-and-run.md](./build-and-run.md#committing-changes--the-bundle-must-stay-in-sync)). After any edit below:

```sh
eval "$(opam env)"
just release            # rebuild the optimized bundle
git add static/main.bc.js <the source files you changed>
```

---

## Add a blog post

1. Create `posts/<slug>.md`. The **filename (minus `.md`) is the URL slug** → the post lives at `/blog/<slug>`.
2. Start the file with frontmatter, then the Markdown body:
   ```markdown
   ---
   title: Building a JSON Parser in Haskell
   date: '2023-12-01'
   description: My first foray into Haskell using parser combinators to parse JSON.
   ---

   # Building a JSON Parser in Haskell

   Body goes here — standard Markdown, rendered by `omd` at build time.
   ```
   - `title`, `date`, `description` are the recognized keys (see `posts/gen.ml`). Quotes are optional and stripped. Posts sort by `date` on the blog index.
3. Rebuild. `posts/gen.ml` regenerates `posts_data.ml` automatically as part of the dune build — no code changes needed. The post appears on `/blog` and is searchable.

> The Markdown → HTML conversion happens at build time; the browser only ever sees pre-rendered HTML.

---

## Add a project

Projects appear as cards on the home page. Editing is in `lib/data.ml`; an optional second entry gives the project a rich detail page.

1. **Add the card** — append a `Project.make` entry to the `projects` list in `lib/data.ml`:
   ```ocaml
   ; make
       ~name:"my_project"
       ~description:"One-line description shown on the card."
       ~language:"Rust"
       ~url:"https://github.com/you/my_project"
       ~featured:true                 (* optional, defaults false *)
       ~tags:[ "systems"; "cli" ]     (* optional, defaults [] *)
       ~created_at:"2026-01-15"       (* YYYY-MM-DD; used for sort order *)
       ()
   ```
2. **(Optional) Add a detail page** — append a record to `all` in `lib/project_details.ml` with `slug` **exactly equal to** the project's `name` above:
   ```ocaml
   ; { slug = "my_project"
     ; overview = "Longer prose description."
     ; languages = [ "Rust", 271223; "Shell", 1202 ]   (* name, bytes *)
     ; loc = "~15.3k"
     ; area = "Systems Programming"
     ; use_cases = [ "..."; "..." ]
     ; features = [ "..."; "..." ]
     ; tech_stack = [ "Rust"; "SDL2" ]
     }
   ```
   - `languages` are byte counts; percentages for the language bar are computed by `Project_details.percentages`.
   - **Linking behavior:** `lib/project_card.ml` links the card to the **internal** detail route only when `Project_details.has name` is true. Without a matching `project_details.ml` entry, the card links straight to the GitHub `url`.
3. Rebuild.

---

## Add a contribution

Open-source contributions appear on the home page and get a detail page at `/contributions/<slug>`. Append a record to `contributions` in `lib/data.ml`:

```ocaml
; { slug = "rmpc"                       (* URL slug for the detail page *)
  ; project = "rmpc"
  ; project_description = "..."
  ; project_url = "https://github.com/mierak/rmpc"
  ; project_stars = 2550
  ; language = "Rust"
  ; pr =
      { title = "feat: add block album_art support"
      ; number = 377
      ; url = "https://github.com/mierak/rmpc/pull/377"
      ; state = "MERGED"
      ; merged_at = "2025-05-30"        (* used for sort order *)
      ; description = "..."
      }
  ; overview = "..."
  ; area = "Terminal Graphics / TUI"
  ; tech_stack = [ "Rust"; "ratatui" ]
  }
```

No separate details module — the contribution card and detail page both read this record. Rebuild.

---

## Edit hero / about / skills / experience / contacts

All in `lib/data.ml`:

| To change… | Edit |
| --- | --- |
| Name, title, tagline | `Hero.value` / `Hero.sub` |
| About paragraphs | `about` (list of strings) |
| GitHub / email / LinkedIn / CTA | `Contacts.value` |
| Skills (grouped) | `skills` (`Skill_category` list) |
| Work timeline | `experiences` (`Experience` list) |

Rebuild after editing.

---

## Add a new route / page type

Routing is typed, so a new page means touching three places:

1. **`lib/route.ml`** — add a constructor to `Url.t`, e.g. `| Notes of string`. Then:
   - add its case to `parser_for_variant` (define the URL path, e.g. `Parser.with_prefix [ "notes" ] (Parser.from_path Value_parser.string)`);
   - add its case to `to_path` (e.g. `| Notes slug -> "/notes/" ^ slug`).
2. **`lib/app.ml`** — add the matching arm in `match%sub Route.value` that renders your new page component.
3. **Create the page module** (`lib/notes_page.ml`) exposing a `component` (use `let%arr slug = slug in …` if it takes a slug), following the pattern of `blog_post.ml` / `project_detail_page.ml`. Reuse `Ui.*` helpers for consistency.

Because `Url.t` derives `typed_variants`, the compiler will force you to handle the new variant everywhere — a missing case is a build error, not a runtime bug. Rebuild.

---

## After any change — verify

```sh
just check      # typecheck/compile
just release    # optimized bundle
just serve      # → http://localhost:8099/  (check your change in the browser)
git add static/main.bc.js <changed sources>
```
