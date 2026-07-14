open! Core
open! Bonsai_web

let link_attrs (project : Data.Project.t) =
  if Project_details.has project.name
  then Route.link_attrs (Route.Url.Project project.name)
  else Ui.external_link_attrs ~href:project.url
;;

let view (project : Data.Project.t) =
  Vdom.Node.a
    ~attrs:(Vdom.Attr.classes [ "project-card"; "bordered" ] :: link_attrs project)
    [ Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "card-header" ]
        [ Vdom.Node.span
            ~attrs:[ Vdom.Attr.class_ "card-name" ]
            [ Vdom.Node.text project.name ]
        ]
    ; Vdom.Node.p
        ~attrs:[ Vdom.Attr.class_ "card-desc" ]
        [ Vdom.Node.text project.description ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "card-footer" ]
        [ Vdom.Node.span
            ~attrs:[ Vdom.Attr.class_ "card-lang" ]
            [ Vdom.Node.text project.language ]
        ; Vdom.Node.span ~attrs:[ Vdom.Attr.class_ "card-arrow" ] [ Vdom.Node.text "↗" ]
        ]
    ]
;;
