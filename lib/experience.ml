open! Core
open! Bonsai_web

let item_view (exp : Data.Experience.t) =
  Vdom.Node.div
    ~attrs:[ Vdom.Attr.classes [ "timeline-item"; "bordered" ] ]
    [ Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "timeline-header" ]
        [ Vdom.Node.span
            ~attrs:[ Vdom.Attr.class_ "timeline-role" ]
            [ Vdom.Node.text exp.role ]
        ; Vdom.Node.span
            ~attrs:[ Vdom.Attr.classes [ "timeline-date"; "subtext" ] ]
            [ Vdom.Node.text exp.timeline ]
        ]
    ; Vdom.Node.p
        ~attrs:[ Vdom.Attr.class_ "timeline-company" ]
        [ Vdom.Node.text exp.company ]
    ; Vdom.Node.p
        ~attrs:[ Vdom.Attr.classes [ "timeline-desc"; "subtext" ] ]
        [ Vdom.Node.text exp.description ]
    ]
;;

let view =
  Vdom.Node.create
    "section"
    ~attrs:[ Vdom.Attr.id "experience"; Vdom.Attr.class_ "experience-section" ]
    [ Vdom.Node.h2
        ~attrs:[ Vdom.Attr.class_ "section-title" ]
        [ Vdom.Node.text "Experience" ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "timeline" ]
        (List.map Data.experiences ~f:item_view)
    ]
;;
