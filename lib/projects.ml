open! Core
open! Bonsai_web
open Bonsai.Let_syntax

(* Sort order persisted to localStorage under "sort-projects" with the exact
   string values ("newest"/"oldest") the original SvelteKit app used, so the
   two apps share the key. Persistent_var is reactive: setting it re-renders. *)
let store =
  Bonsai_web.Persistent_var.create
    (module String)
    `Local_storage
    ~unique_id:"sort-projects"
    ~default:"newest"
;;

let sorted ~newest =
  List.sort Data.projects ~compare:(fun (a : Data.Project.t) b ->
    let c = String.compare a.created_at b.created_at in
    if newest then -c else c)
;;

let component =
  let%arr sort = Bonsai_web.Persistent_var.value store in
  let newest = String.equal sort "newest" in
  let next = if newest then "oldest" else "newest" in
  let label = if newest then "Newest first" else "Oldest first" in
  Vdom.Node.create "section"
    ~attrs:[ Vdom.Attr.id "projects"; Vdom.Attr.class_ "projects-section" ]
    [ Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "section-header" ]
        [ Vdom.Node.h2
            ~attrs:[ Vdom.Attr.class_ "section-title" ]
            [ Vdom.Node.text "Projects" ]
        ; Vdom.Node.button
            ~attrs:
              [ Vdom.Attr.class_ "sort-btn"
              ; Vdom.Attr.on_click (fun _ ->
                  Bonsai_web.Persistent_var.effect store next)
              ]
            [ Vdom.Node.text label ]
        ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "projects-grid" ]
        (List.map (sorted ~newest) ~f:Project_card.view)
    ]
;;
