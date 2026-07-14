open! Core
open! Bonsai_web

let view =
  Vdom.Node.create "nav"
    [ Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "nav-left" ]
        [ Vdom.Node.a
            ~attrs:(Vdom.Attr.class_ "logo" :: Route.link_attrs Route.Url.Home)
            [ Vdom.Node.text "s"
            ; Vdom.Node.span ~attrs:[ Vdom.Attr.class_ "logo-bold" ] [ Vdom.Node.text "m" ]
            ]
        ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "nav-right" ]
        [ Vdom.Node.ul
            ~attrs:[ Vdom.Attr.class_ "nav-links" ]
            [ Vdom.Node.li [ Vdom.Node.a ~attrs:[ Vdom.Attr.href "/#projects" ] [ Vdom.Node.text "Projects" ] ]
            ; Vdom.Node.li [ Vdom.Node.a ~attrs:[ Vdom.Attr.href "/#skills" ] [ Vdom.Node.text "Skills" ] ]
            ; Vdom.Node.li [ Vdom.Node.a ~attrs:[ Vdom.Attr.href "/#experience" ] [ Vdom.Node.text "Experience" ] ]
            ; Vdom.Node.li [ Vdom.Node.a ~attrs:(Route.link_attrs Route.Url.Blog) [ Vdom.Node.text "Blog" ] ]
            ]
        ]
    ]
;;
