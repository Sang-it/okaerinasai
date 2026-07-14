open! Core
open! Bonsai_web
open Bonsai.Let_syntax

let back_link = Ui.back_link ~route:Route.Url.Blog "← back to blog"

let render (p : Posts_data.t) =
  Vdom.Node.create
    "article"
    ~attrs:[ Vdom.Attr.class_ "blog-post" ]
    [ Vdom.Node.create
        "header"
        ~attrs:[ Vdom.Attr.class_ "post-header" ]
        [ back_link
        ; Vdom.Node.h1 [ Vdom.Node.text p.title ]
        ; Vdom.Node.p
            ~attrs:[ Vdom.Attr.classes [ "post-date"; "subtext" ] ]
            [ Vdom.Node.text p.date ]
        ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "post-content" ]
        [ Vdom.Node.inner_html
            ~tag:"div"
            ~attrs:[]
            ~this_html_is_sanitized_and_is_totally_safe_trust_me:p.html
            ()
        ]
    ]
;;

let not_found slug =
  Ui.not_found
    ~tag:"section"
    ~class_:"blog-post"
    ~back:back_link
    ~title:"Post not found"
    ~message:(sprintf "No post: %s" slug)
;;

let component slug =
  let%arr slug = slug in
  match
    List.find Posts_data.posts ~f:(fun (p : Posts_data.t) -> String.equal p.slug slug)
  with
  | Some p -> render p
  | None -> not_found slug
;;
