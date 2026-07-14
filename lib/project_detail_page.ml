open! Core
open! Bonsai_web
open Bonsai.Let_syntax

let render (project : Data.Project.t) (extras : Project_details.t) =
  let pcts = Project_details.percentages extras.languages in
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
  Vdom.Node.create
    "article"
    ~attrs:[ Vdom.Attr.class_ "project-detail" ]
    [ Vdom.Node.create
        "header"
        [ Ui.back_link ~route:Route.Url.Home "← back to projects"
        ; Vdom.Node.h1 [ Vdom.Node.text project.name ]
        ; Vdom.Node.p
            ~attrs:[ Vdom.Attr.class_ "description" ]
            [ Vdom.Node.text project.description ]
        ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "meta-row" ]
        [ Ui.meta_item ~label:"area" ~value:extras.area
        ; Ui.meta_item ~label:"language" ~value:project.language
        ; Ui.meta_item ~label:"loc" ~value:extras.loc
        ; Ui.meta_item ~label:"created" ~value:project.created_at
        ]
    ; Ui.section
        ~title:"Overview"
        [ Vdom.Node.p
            ~attrs:[ Vdom.Attr.class_ "body-text" ]
            [ Vdom.Node.text extras.overview ]
        ]
    ; Ui.section ~title:"Languages" [ lang_bar; lang_list ]
    ; Ui.section ~title:"Features" [ Ui.detail_list extras.features ]
    ; Ui.section ~title:"Use Cases" [ Ui.detail_list extras.use_cases ]
    ; Ui.section ~title:"Tech Stack" [ Ui.tags extras.tech_stack ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "project-link" ]
        [ Ui.external_link ~href:project.url "View on GitHub ↗" ]
    ]
;;

let not_found slug =
  Ui.not_found
    ~tag:"article"
    ~class_:"project-detail"
    ~back:(Ui.back_link ~route:Route.Url.Home "← back to projects")
    ~title:"Project not found"
    ~message:(sprintf "No project: %s" slug)
;;

let component slug =
  let%arr slug = slug in
  match Data.find_project ~name:slug, Project_details.find slug with
  | Some project, Some extras -> render project extras
  | _ -> not_found slug
;;
