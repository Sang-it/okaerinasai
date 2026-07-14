open! Core
open! Bonsai_web
open Bonsai.Let_syntax

let store =
  Bonsai_web.Persistent_var.create
    (module String)
    `Local_storage
    ~unique_id:"sort-contributions"
    ~default:"newest"
;;

let sorted ~newest =
  List.sort Data.contributions ~compare:(fun (a : Data.Contribution.t) b ->
    let c = String.compare a.pr.merged_at b.pr.merged_at in
    if newest then -c else c)
;;

let star_svg =
  {svg|<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" /></svg>|svg}
;;

let card (c : Data.Contribution.t) =
  Vdom.Node.a
    ~attrs:
      (Vdom.Attr.classes [ "contrib-card"; "bordered" ]
       :: Route.link_attrs (Route.Url.Contribution c.slug))
    [ Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "contrib-header" ]
        [ Vdom.Node.div
            ~attrs:[ Vdom.Attr.class_ "contrib-project" ]
            [ Vdom.Node.span
                ~attrs:[ Vdom.Attr.class_ "contrib-name" ]
                [ Vdom.Node.text c.project ]
            ; Vdom.Node.span
                ~attrs:[ Vdom.Attr.class_ "contrib-stars" ]
                [ Vdom.Node.inner_html
                    ~tag:"span"
                    ~attrs:[]
                    ~this_html_is_sanitized_and_is_totally_safe_trust_me:star_svg
                    ()
                ; Vdom.Node.text (Int.to_string c.project_stars)
                ]
            ]
        ; Vdom.Node.span
            ~attrs:[ Vdom.Attr.class_ "contrib-lang" ]
            [ Vdom.Node.text c.language ]
        ]
    ; Vdom.Node.p
        ~attrs:[ Vdom.Attr.class_ "contrib-project-desc" ]
        [ Vdom.Node.text c.project_description ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "contrib-footer" ]
        [ Vdom.Node.div
            ~attrs:[ Vdom.Attr.class_ "contrib-pr" ]
            [ Vdom.Node.span ~attrs:[ Vdom.Attr.class_ "pr-badge" ] [ Vdom.Node.text c.pr.state ]
            ; Vdom.Node.span ~attrs:[ Vdom.Attr.class_ "pr-title" ] [ Vdom.Node.text c.pr.title ]
            ; Vdom.Node.span
                ~attrs:[ Vdom.Attr.class_ "pr-number" ]
                [ Vdom.Node.text ("#" ^ Int.to_string c.pr.number) ]
            ]
        ; Vdom.Node.span ~attrs:[ Vdom.Attr.class_ "contrib-arrow" ] [ Vdom.Node.text "↗" ]
        ]
    ]
;;

let component =
  let%arr sort = Bonsai_web.Persistent_var.value store in
  let newest = String.equal sort "newest" in
  let next = if newest then "oldest" else "newest" in
  let label = if newest then "Newest first" else "Oldest first" in
  Vdom.Node.create "section"
    ~attrs:[ Vdom.Attr.id "contributions"; Vdom.Attr.class_ "contributions-section" ]
    [ Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "section-header" ]
        [ Vdom.Node.h2
            ~attrs:[ Vdom.Attr.class_ "section-title" ]
            [ Vdom.Node.text "Contributions" ]
        ; Vdom.Node.button
            ~attrs:
              [ Vdom.Attr.class_ "sort-btn"
              ; Vdom.Attr.on_click (fun _ ->
                  Bonsai_web.Persistent_var.effect store next)
              ]
            [ Vdom.Node.text label ]
        ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "contributions-list" ]
        (List.map (sorted ~newest) ~f:card)
    ]
;;
