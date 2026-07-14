open! Core
open! Bonsai_web

let category_view (category : Data.Skill_category.t) =
  Vdom.Node.div
    ~attrs:[ Vdom.Attr.classes [ "skill-category"; "bordered" ] ]
    [ Vdom.Node.h3
        ~attrs:[ Vdom.Attr.class_ "skill-category-name" ]
        [ Vdom.Node.text category.name ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "skill-tags" ]
        (List.map category.items ~f:(fun item ->
           Vdom.Node.span
             ~attrs:[ Vdom.Attr.class_ "skill-tag" ]
             [ Vdom.Node.text item ]))
    ]
;;

let view =
  Vdom.Node.create "section"
    ~attrs:[ Vdom.Attr.id "skills"; Vdom.Attr.class_ "skills-section" ]
    [ Vdom.Node.h2 ~attrs:[ Vdom.Attr.class_ "section-title" ] [ Vdom.Node.text "Skills" ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "skills-grid" ]
        (List.map Data.skills ~f:category_view)
    ]
;;
