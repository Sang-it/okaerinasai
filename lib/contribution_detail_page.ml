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
  Vdom.Node.create "section"
    ~attrs:[ Vdom.Attr.class_ "section" ]
    (Vdom.Node.h2 [ Vdom.Node.text title ] :: children)
;;

(* Matches JS Number.toLocaleString() thousands grouping, e.g. 2550 -> "2,550". *)
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
  Vdom.Node.create "article"
    ~attrs:[ Vdom.Attr.class_ "contrib-detail" ]
    [ Vdom.Node.create "header"
        [ Vdom.Node.a
            ~attrs:(Vdom.Attr.class_ "back-link" :: Route.link_attrs Route.Url.Home)
            [ Vdom.Node.text "← back to contributions" ]
        ; Vdom.Node.h1 [ Vdom.Node.text c.project ]
        ; Vdom.Node.p
            ~attrs:[ Vdom.Attr.class_ "description" ]
            [ Vdom.Node.text c.project_description ]
        ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "meta-row" ]
        [ meta_item ~label:"area" ~value:c.area
        ; meta_item ~label:"language" ~value:c.language
        ; meta_item ~label:"stars" ~value:(with_commas c.project_stars)
        ; meta_item ~label:"merged" ~value:c.pr.merged_at
        ]
    ; section ~title:"Pull Request"
        [ Vdom.Node.div
            ~attrs:[ Vdom.Attr.class_ "pr-info" ]
            [ Vdom.Node.span
                ~attrs:[ Vdom.Attr.class_ "pr-badge" ]
                [ Vdom.Node.text c.pr.state ]
            ; Vdom.Node.a
                ~attrs:
                  [ Vdom.Attr.class_ "pr-link"
                  ; Vdom.Attr.href c.pr.url
                  ; Vdom.Attr.create "target" "_blank"
                  ; Vdom.Attr.create "rel" "noopener noreferrer"
                  ]
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
    ; section ~title:"Overview"
        [ Vdom.Node.p ~attrs:[ Vdom.Attr.class_ "body-text" ] [ Vdom.Node.text c.overview ] ]
    ; section ~title:"Tech Stack"
        [ Vdom.Node.div
            ~attrs:[ Vdom.Attr.class_ "tags" ]
            (List.map c.tech_stack ~f:(fun t ->
               Vdom.Node.span ~attrs:[ Vdom.Attr.class_ "tag" ] [ Vdom.Node.text t ]))
        ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "project-link" ]
        [ Vdom.Node.a
            ~attrs:
              [ Vdom.Attr.href c.project_url
              ; Vdom.Attr.create "target" "_blank"
              ; Vdom.Attr.create "rel" "noopener noreferrer"
              ]
            [ Vdom.Node.text "View project on GitHub ↗" ]
        ]
    ]
;;

let not_found slug =
  Vdom.Node.create "article"
    ~attrs:[ Vdom.Attr.class_ "contrib-detail" ]
    [ Vdom.Node.a
        ~attrs:(Vdom.Attr.class_ "back-link" :: Route.link_attrs Route.Url.Home)
        [ Vdom.Node.text "← back to contributions" ]
    ; Vdom.Node.h1 [ Vdom.Node.text "Contribution not found" ]
    ; Vdom.Node.p
        ~attrs:[ Vdom.Attr.class_ "subtext" ]
        [ Vdom.Node.text (sprintf "No contribution: %s" slug) ]
    ]
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
