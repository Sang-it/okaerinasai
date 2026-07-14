open! Core
open! Bonsai_web

let view =
  Vdom.Node.create
    "nav"
    [ Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "nav-left" ]
        [ Vdom.Node.a
            ~attrs:(Vdom.Attr.class_ "logo" :: Route.link_attrs Route.Url.Home)
            [ Vdom.Node.text "s"
            ; Vdom.Node.span
                ~attrs:[ Vdom.Attr.class_ "logo-bold" ]
                [ Vdom.Node.text "m" ]
            ]
        ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "nav-right" ]
        [ Vdom.Node.ul
            ~attrs:[ Vdom.Attr.class_ "nav-links" ]
            [ Vdom.Node.li [ Ui.nav_scroll_link ~id:"projects" "Projects" ]
            ; Vdom.Node.li [ Ui.nav_scroll_link ~id:"skills" "Skills" ]
            ; Vdom.Node.li [ Ui.nav_scroll_link ~id:"experience" "Experience" ]
            ; Vdom.Node.li
                [ Vdom.Node.a
                    ~attrs:(Route.link_attrs Route.Url.Blog)
                    [ Vdom.Node.text "Blog" ]
                ]
            ]
        ]
    ]
;;
