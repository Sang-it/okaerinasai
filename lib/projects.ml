open! Core
open! Bonsai_web
open Bonsai.Let_syntax

let store = Ui.make_sort_store ~unique_id:"sort-projects"

let sorted ~newest =
  List.sort Data.projects ~compare:(fun (a : Data.Project.t) b ->
    let c = String.compare a.created_at b.created_at in
    if newest then -c else c)
;;

let component =
  let%arr sort = Bonsai_web.Persistent_var.value store in
  Vdom.Node.create
    "section"
    ~attrs:[ Vdom.Attr.id "projects"; Vdom.Attr.class_ "projects-section" ]
    [ Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "section-header" ]
        [ Vdom.Node.h2
            ~attrs:[ Vdom.Attr.class_ "section-title" ]
            [ Vdom.Node.text "Projects" ]
        ; Ui.sort_button store sort
        ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "projects-grid" ]
        (List.map (sorted ~newest:(Sort.is_newest sort)) ~f:Project_card.view)
    ]
;;
