open! Core
open! Bonsai_web
open Bonsai.Let_syntax

let component =
  let%sub content =
    match%sub Route.value with
    | Route.Url.Home -> Home.component
    | Route.Url.Blog -> Blog_index.component
    | Route.Url.Blog_post slug -> Blog_post.component slug
    | Route.Url.Project slug -> Project_detail_page.component slug
    | Route.Url.Contribution slug -> Contribution_detail_page.component slug
  in
  let%arr content = content in
  Vdom.Node.div
    [ Vdom.Node.div
        ~attrs:[ Vdom.Attr.class_ "page-box" ]
        [ Nav.view; Vdom.Node.create "main" [ content ] ]
    ; Footer.view
    ]
;;
