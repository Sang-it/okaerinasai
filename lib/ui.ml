open! Core
open! Bonsai_web

let external_link_attrs ~href =
  [ Vdom.Attr.href href
  ; Vdom.Attr.create "target" "_blank"
  ; Vdom.Attr.create "rel" "noopener noreferrer"
  ]
;;

let external_link ?(attrs = []) ~href label =
  Vdom.Node.a ~attrs:(attrs @ external_link_attrs ~href) [ Vdom.Node.text label ]
;;

let back_link ~route label =
  Vdom.Node.a
    ~attrs:(Vdom.Attr.class_ "back-link" :: Route.link_attrs route)
    [ Vdom.Node.text label ]
;;

let scroll_to id =
  Vdom.Effect.of_sync_fun
    (fun () ->
       let open Js_of_ocaml in
       let scroll () =
         Option.iter (Dom_html.getElementById_opt id) ~f:(fun el ->
           el##scrollIntoView Js._true)
       in
       let raf f =
         ignore
           (Dom_html.window##requestAnimationFrame (Js.wrap_callback (fun _ -> f ())))
       in
       raf (fun () -> raf scroll))
    ()
;;

let nav_scroll_link ~id label =
  Vdom.Node.a
    ~attrs:
      [ Vdom.Attr.href ("/#" ^ id)
      ; Vdom.Attr.on_click (fun _ ->
          Vdom.Effect.Many
            [ Vdom.Effect.Prevent_default; Route.set_effect Route.Url.Home; scroll_to id ])
      ]
    [ Vdom.Node.text label ]
;;

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

let tags ts =
  Vdom.Node.div
    ~attrs:[ Vdom.Attr.class_ "tags" ]
    (List.map ts ~f:(fun t ->
       Vdom.Node.span ~attrs:[ Vdom.Attr.class_ "tag" ] [ Vdom.Node.text t ]))
;;

let detail_list items =
  Vdom.Node.ul
    ~attrs:[ Vdom.Attr.class_ "detail-list" ]
    (List.map items ~f:(fun i -> Vdom.Node.li [ Vdom.Node.text i ]))
;;

let not_found ~tag ~class_ ~back ~title ~message =
  Vdom.Node.create
    tag
    ~attrs:[ Vdom.Attr.class_ class_ ]
    [ back
    ; Vdom.Node.h1 [ Vdom.Node.text title ]
    ; Vdom.Node.p ~attrs:[ Vdom.Attr.class_ "subtext" ] [ Vdom.Node.text message ]
    ]
;;

let make_sort_store ~unique_id =
  Bonsai_web.Persistent_var.create
    (module Sort)
    `Local_storage
    ~unique_id
    ~default:Sort.Newest
;;

let sort_button store sort =
  Vdom.Node.button
    ~attrs:
      [ Vdom.Attr.class_ "sort-btn"
      ; Vdom.Attr.on_click (fun _ ->
          Bonsai_web.Persistent_var.effect store (Sort.toggle sort))
      ]
    [ Vdom.Node.text (Sort.label sort) ]
;;
