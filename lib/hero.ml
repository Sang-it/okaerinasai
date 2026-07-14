open! Core
open! Bonsai_web

let view =
  let hero = Data.Hero.value in
  Vdom.Node.create
    "section"
    ~attrs:[ Vdom.Attr.class_ "hero" ]
    [ Vdom.Node.p
        ~attrs:[ Vdom.Attr.class_ "hero-greeting" ]
        [ Vdom.Node.text hero.greeting ]
    ; Vdom.Node.h1
        ~attrs:[ Vdom.Attr.class_ "hero-name" ]
        [ Vdom.Node.span
            ~attrs:[ Vdom.Attr.class_ "name-first" ]
            [ Vdom.Node.text hero.first_name ]
        ; Vdom.Node.text " "
        ; Vdom.Node.span
            ~attrs:[ Vdom.Attr.class_ "name-last" ]
            [ Vdom.Node.text hero.last_name ]
        ]
    ; Vdom.Node.p
        ~attrs:[ Vdom.Attr.classes [ "hero-sub"; "subtext" ] ]
        [ Vdom.Node.text Data.Hero.sub ]
    ]
;;
