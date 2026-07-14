open! Core
open! Bonsai_web

let view =
  Vdom.Node.create "section"
    ~attrs:[ Vdom.Attr.id "about"; Vdom.Attr.class_ "about-section" ]
    [ Vdom.Node.h2 ~attrs:[ Vdom.Attr.class_ "section-title" ] [ Vdom.Node.text "About" ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "about-content" ]
        (List.map Data.about ~f:(fun para -> Vdom.Node.p [ Vdom.Node.text para ]))
    ]
;;
