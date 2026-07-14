open! Core
open! Bonsai_web
open Bonsai.Let_syntax

let with_commas n =
  let s = Int.to_string (abs n) in
  let len = String.length s in
  let buf = Buffer.create (len + (len / 3)) in
  String.iteri s ~f:(fun i c ->
    if i > 0 && (len - i) % 3 = 0 then Buffer.add_char buf ',';
    Buffer.add_char buf c);
  (if n < 0 then "-" else "") ^ Buffer.contents buf
;;

let render (c : Data.Contribution.t) =
  Vdom.Node.create
    "article"
    ~attrs:[ Vdom.Attr.class_ "contrib-detail" ]
    [ Vdom.Node.create
        "header"
        [ Ui.back_link ~route:Route.Url.Home "← back to contributions"
        ; Vdom.Node.h1 [ Vdom.Node.text c.project ]
        ; Vdom.Node.p
            ~attrs:[ Vdom.Attr.class_ "description" ]
            [ Vdom.Node.text c.project_description ]
        ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "meta-row" ]
        [ Ui.meta_item ~label:"area" ~value:c.area
        ; Ui.meta_item ~label:"language" ~value:c.language
        ; Ui.meta_item ~label:"stars" ~value:(with_commas c.project_stars)
        ; Ui.meta_item ~label:"merged" ~value:c.pr.merged_at
        ]
    ; Ui.section
        ~title:"Pull Request"
        [ Vdom.Node.div
            ~attrs:[ Vdom.Attr.class_ "pr-info" ]
            [ Vdom.Node.span
                ~attrs:[ Vdom.Attr.class_ "pr-badge" ]
                [ Vdom.Node.text c.pr.state ]
            ; Vdom.Node.a
                ~attrs:
                  (Vdom.Attr.class_ "pr-link" :: Ui.external_link_attrs ~href:c.pr.url)
                [ Vdom.Node.text (c.pr.title ^ " ")
                ; Vdom.Node.span
                    ~attrs:[ Vdom.Attr.class_ "pr-number" ]
                    [ Vdom.Node.text ("#" ^ Int.to_string c.pr.number) ]
                ; Vdom.Node.text " ↗"
                ]
            ]
        ; Vdom.Node.p
            ~attrs:[ Vdom.Attr.class_ "body-text" ]
            [ Vdom.Node.text c.pr.description ]
        ]
    ; Ui.section
        ~title:"Overview"
        [ Vdom.Node.p
            ~attrs:[ Vdom.Attr.class_ "body-text" ]
            [ Vdom.Node.text c.overview ]
        ]
    ; Ui.section ~title:"Tech Stack" [ Ui.tags c.tech_stack ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "project-link" ]
        [ Ui.external_link ~href:c.project_url "View project on GitHub ↗" ]
    ]
;;

let not_found slug =
  Ui.not_found
    ~tag:"article"
    ~class_:"contrib-detail"
    ~back:(Ui.back_link ~route:Route.Url.Home "← back to contributions")
    ~title:"Contribution not found"
    ~message:(sprintf "No contribution: %s" slug)
;;

let component slug =
  let%arr slug = slug in
  match
    List.find Data.contributions ~f:(fun (c : Data.Contribution.t) ->
      String.equal c.slug slug)
  with
  | Some c -> render c
  | None -> not_found slug
;;
