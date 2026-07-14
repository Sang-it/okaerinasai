open! Core
open! Bonsai_web

(* Original computes the year via new Date().getFullYear() at render time.
   For a static build we resolve it once from the JS runtime clock. *)
let current_year =
  let d = new%js Js_of_ocaml.Js.date_now in
  d##getFullYear
;;

let link_box ?(external_ = false) ~href label =
  let extra =
    if external_
    then
      [ Vdom.Attr.create "target" "_blank"; Vdom.Attr.create "rel" "noopener noreferrer" ]
    else []
  in
  Vdom.Node.a
    ~attrs:(Vdom.Attr.class_ "footer-link-box" :: Vdom.Attr.href href :: extra)
    [ Vdom.Node.text label ]
;;

let link_box_route ~route label =
  Vdom.Node.a
    ~attrs:(Vdom.Attr.class_ "footer-link-box" :: Route.link_attrs route)
    [ Vdom.Node.text label ]
;;

let view =
  let hero = Data.Hero.value in
  let contacts = Data.Contacts.value in
  Vdom.Node.create
    "footer"
    [ Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "footer-links-row" ]
        [ link_box ~external_:true ~href:contacts.github "GitHub"
        ; link_box ~href:contacts.email "Email"
        ; link_box ~external_:true ~href:contacts.linkedin "LinkedIn"
        ; link_box_route ~route:Route.Url.Blog "Blog"
        ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "footer-bottom" ]
        [ Vdom.Node.span
            [ Vdom.Node.text
                (Printf.sprintf "© %d %s %s" current_year hero.first_name hero.last_name)
            ]
        ]
    ]
;;
