open! Core
open! Bonsai_web

let star_svg =
  {svg|<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" /></svg>|svg}
;;

let stars_node stars =
  match stars with
  | Some n when n > 0 ->
    [ Vdom.Node.span
        ~attrs:[ Vdom.Attr.class_ "card-stars" ]
        [ Vdom.Node.inner_html
            ~tag:"span"
            ~attrs:[]
            ~this_html_is_sanitized_and_is_totally_safe_trust_me:star_svg
            ()
        ; Vdom.Node.text (Int.to_string n)
        ]
    ]
  | _ -> []
;;

(* Links internally to /projects/{name} when a project-details entry exists
   (SPA nav); otherwise opens the GitHub URL in a new tab. Mirrors the original
   ProjectCard's `hasDetail = project.name in projectDetails` decision. *)
let link_attrs (project : Data.Project.t) =
  if Project_details.has project.name
  then Route.link_attrs (Route.Url.Project project.name)
  else
    [ Vdom.Attr.href project.url
    ; Vdom.Attr.create "target" "_blank"
    ; Vdom.Attr.create "rel" "noopener noreferrer"
    ]
;;

let view (project : Data.Project.t) =
  Vdom.Node.a
    ~attrs:(Vdom.Attr.classes [ "project-card"; "bordered" ] :: link_attrs project)
    [ Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "card-header" ]
        (Vdom.Node.span
           ~attrs:[ Vdom.Attr.class_ "card-name" ]
           [ Vdom.Node.text project.name ]
         :: stars_node project.stars)
    ; Vdom.Node.p
        ~attrs:[ Vdom.Attr.class_ "card-desc" ]
        [ Vdom.Node.text project.description ]
    ; Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "card-footer" ]
        [ Vdom.Node.span
            ~attrs:[ Vdom.Attr.class_ "card-lang" ]
            [ Vdom.Node.text project.language ]
        ; Vdom.Node.span ~attrs:[ Vdom.Attr.class_ "card-arrow" ] [ Vdom.Node.text "↗" ]
        ]
    ]
;;
