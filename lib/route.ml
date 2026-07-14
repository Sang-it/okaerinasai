open! Core
open! Bonsai_web
module Url_var = Bonsai_web_ui_url_var
module Parser = Uri_parsing.Parser
module Value_parser = Uri_parsing.Value_parser

module Url = struct
  type t =
    | Home
    | Blog
    | Blog_post of string
    | Project of string
    | Contribution of string
  [@@deriving typed_variants, sexp, equal]

  let parser_for_variant : type a. a Typed_variant.t -> a Parser.t = function
    | Home -> Parser.end_of_path Parser.unit
    | Blog -> Parser.with_remaining_path [ "blog" ] Parser.unit
    | Blog_post -> Parser.with_prefix [ "blog" ] (Parser.from_path Value_parser.string)
    | Project -> Parser.with_prefix [ "projects" ] (Parser.from_path Value_parser.string)
    | Contribution ->
      Parser.with_prefix [ "contributions" ] (Parser.from_path Value_parser.string)
  ;;
end

let parser = Parser.Variant.make (module Url)
let versioned = Uri_parsing.Versioned_parser.first_parser parser

let url_var =
  Url_var.Typed.make (module Url) versioned ~fallback:(fun _exn _components -> Url.Home)
;;

let value = Url_var.value url_var

let to_path = function
  | Url.Home -> "/"
  | Url.Blog -> "/blog"
  | Url.Blog_post slug -> "/blog/" ^ slug
  | Url.Project slug -> "/projects/" ^ slug
  | Url.Contribution slug -> "/contributions/" ^ slug
;;

let set_effect ?(how = `Push) route = Url_var.set_effect ~how url_var route

let scroll_to_top =
  Vdom.Effect.of_sync_fun (fun () -> Js_of_ocaml.Dom_html.window##scroll 0 0) ()
;;

let link_attrs route =
  [ Vdom.Attr.href (to_path route)
  ; Vdom.Attr.on_click (fun _ ->
      Vdom.Effect.Many [ Vdom.Effect.Prevent_default; set_effect route; scroll_to_top ])
  ]
;;
