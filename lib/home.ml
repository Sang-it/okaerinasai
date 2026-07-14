open! Core
open! Bonsai_web
open Bonsai.Let_syntax

let divider = Vdom.Node.create "hr" ~attrs:[ Vdom.Attr.class_ "section-divider" ] []

let component =
  let%sub projects = Projects.component in
  let%sub contributions = Contributions.component in
  let%arr projects = projects
  and contributions = contributions in
  Vdom.Node.div
    [ Hero.view
    ; divider
    ; About.view
    ; divider
    ; projects
    ; divider
    ; contributions
    ; divider
    ; Skills.view
    ; divider
    ; Experience.view
    ]
;;
