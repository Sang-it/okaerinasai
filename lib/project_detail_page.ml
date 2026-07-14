open! Core
open! Bonsai_web
open Bonsai.Let_syntax

let meta_item ~label ~value =
  Vdom.Node.div
    ~attrs:[ Vdom.Attr.class_ "meta-item" ]
    [ Vdom.Node.span ~attrs:[ Vdom.Attr.class_ "meta-label" ] [ Vdom.Node.text label ]
    ; Vdom.Node.span ~attrs:[ Vdom.Attr.class_ "meta-value" ] [ Vdom.Node.text value ]
    ]
;;

let section ~title children =
  Vdom.Node.create
    "section"
    ~attrs:[ Vdom.Attr.class_ "section" ]
    (Vdom.Node.h2 [ Vdom.Node.text title ] :: children)
;;

let detail_list items =
  Vdom.Node.ul
    ~attrs:[ Vdom.Attr.class_ "detail-list" ]
    (List.map items ~f:(fun i -> Vdom.Node.li [ Vdom.Node.text i ]))
;;

let render (p : Project_details.t) =
  let pcts = Project_details.percentages p.languages in
  let lang_bar =
    Vdom.Node.div
      ~attrs:[ Vdom.Attr.class_ "lang-bar" ]
      (List.map pcts ~f:(fun (name, pct) ->
         let s = Project_details.pct_str pct in
         Vdom.Node.div
           ~attrs:
             [ Vdom.Attr.class_ "lang-segment"
             ; Vdom.Attr.create "style" (sprintf "width: %s%%" s)
             ; Vdom.Attr.create "title" (sprintf "%s — %s%%" name s)
             ]
           []))
  in
  let lang_list =
    Vdom.Node.div
      ~attrs:[ Vdom.Attr.class_ "lang-list" ]
      (List.map pcts ~f:(fun (name, pct) ->
         Vdom.Node.div
           ~attrs:[ Vdom.Attr.class_ "lang-item" ]
           [ Vdom.Node.span
               ~attrs:[ Vdom.Attr.class_ "lang-name" ]
               [ Vdom.Node.text name ]
           ; Vdom.Node.span
               ~attrs:[ Vdom.Attr.class_ "lang-pct" ]
               [ Vdom.Node.text (Project_details.pct_str pct ^ "%") ]
           ]))
  in
  let tags =
    Vdom.Node.div
      ~attrs:[ Vdom.Attr.class_ "tags" ]
      (List.map p.tech_stack ~f:(fun t ->
         Vdom.Node.span ~attrs:[ Vdom.Attr.class_ "tag" ] [ Vdom.Node.text t ]))
  in
  Vdom.Node.create
    "article"
    ~attrs:[ Vdom.Attr.class_ "project-detail" ]
    [ Vdom.Node.create
        "header"
        [ Vdom.Node.a
            ~attrs:(Vdom.Attr.class_ "back-link" :: Route.link_attrs Route.Url.Home)
            [ Vdom.Node.text "← back to projects" ]
        ; Vdom.Node.h1 [ Vdom.Node.text p.name ]
        ; Vdom.Node.p
            ~attrs:[ Vdom.Attr.class_ "description" ]
            [ Vdom.Node.text p.description ]
        ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "meta-row" ]
        [ meta_item ~label:"area" ~value:p.area
        ; meta_item ~label:"language" ~value:p.language
        ; meta_item ~label:"loc" ~value:p.loc
        ; meta_item ~label:"created" ~value:p.created_at
        ]
    ; section
        ~title:"Overview"
        [ Vdom.Node.p
            ~attrs:[ Vdom.Attr.class_ "body-text" ]
            [ Vdom.Node.text p.overview ]
        ]
    ; section ~title:"Languages" [ lang_bar; lang_list ]
    ; section ~title:"Features" [ detail_list p.features ]
    ; section ~title:"Use Cases" [ detail_list p.use_cases ]
    ; section ~title:"Tech Stack" [ tags ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "project-link" ]
        [ Vdom.Node.a
            ~attrs:
              [ Vdom.Attr.href p.url
              ; Vdom.Attr.create "target" "_blank"
              ; Vdom.Attr.create "rel" "noopener noreferrer"
              ]
            [ Vdom.Node.text "View on GitHub ↗" ]
        ]
    ]
;;

let not_found slug =
  Vdom.Node.create
    "article"
    ~attrs:[ Vdom.Attr.class_ "project-detail" ]
    [ Vdom.Node.a
        ~attrs:(Vdom.Attr.class_ "back-link" :: Route.link_attrs Route.Url.Home)
        [ Vdom.Node.text "← back to projects" ]
    ; Vdom.Node.h1 [ Vdom.Node.text "Project not found" ]
    ; Vdom.Node.p
        ~attrs:[ Vdom.Attr.class_ "subtext" ]
        [ Vdom.Node.text (sprintf "No project: %s" slug) ]
    ]
;;

let component slug =
  let%arr slug = slug in
  match Project_details.find slug with
  | Some p -> render p
  | None -> not_found slug
;;
