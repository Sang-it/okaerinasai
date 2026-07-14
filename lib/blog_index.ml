open! Core
open! Bonsai_web
open Bonsai.Let_syntax

let store = Ui.make_sort_store ~unique_id:"sort-blog"

let subsequence ~query title =
  let q = String.lowercase (String.strip query) in
  if String.is_empty q
  then true
  else (
    let t = String.lowercase title in
    let qn = String.length q
    and tn = String.length t in
    let ti = ref 0
    and qi = ref 0
    and ok = ref true in
    while !ok && !qi < qn do
      let found = ref (-1)
      and j = ref !ti in
      while !found < 0 && !j < tn do
        if Char.equal t.[!j] q.[!qi] then found := !j;
        incr j
      done;
      if !found < 0
      then ok := false
      else (
        ti := !found + 1;
        incr qi)
    done;
    !ok)
;;

let filtered ~query ~newest =
  Posts_data.posts
  |> List.filter ~f:(fun (p : Posts_data.t) -> subsequence ~query p.title)
  |> List.sort ~compare:(fun (a : Posts_data.t) b ->
    let c = String.compare a.date b.date in
    if newest then -c else c)
;;

let post_card (p : Posts_data.t) =
  let header =
    Vdom.Node.div
      ~attrs:[ Vdom.Attr.class_ "post-header" ]
      [ Vdom.Node.span ~attrs:[ Vdom.Attr.class_ "post-title" ] [ Vdom.Node.text p.title ]
      ; Vdom.Node.span
          ~attrs:[ Vdom.Attr.classes [ "post-date"; "subtext" ] ]
          [ Vdom.Node.text p.date ]
      ]
  in
  let desc =
    if String.is_empty p.description
    then []
    else
      [ Vdom.Node.p
          ~attrs:[ Vdom.Attr.classes [ "post-desc"; "subtext" ] ]
          [ Vdom.Node.text p.description ]
      ]
  in
  Vdom.Node.a
    ~attrs:
      (Vdom.Attr.classes [ "post-card"; "bordered" ]
       :: Route.link_attrs (Route.Url.Blog_post p.slug))
    (header :: desc)
;;

let component =
  let%sub query_state = Bonsai.state (module String) ~default_model:"" in
  let%arr query, set_query = query_state
  and sort = Bonsai_web.Persistent_var.value store in
  let posts = filtered ~query ~newest:(Sort.is_newest sort) in
  let body =
    if List.is_empty Posts_data.posts
    then
      [ Vdom.Node.p
          ~attrs:[ Vdom.Attr.class_ "subtext" ]
          [ Vdom.Node.text "No posts yet. Check back soon." ]
      ]
    else if List.is_empty posts
    then
      [ Vdom.Node.p
          ~attrs:[ Vdom.Attr.class_ "subtext" ]
          [ Vdom.Node.text (sprintf "No posts matching \"%s\"" query) ]
      ]
    else
      [ Vdom.Node.div
          ~attrs:[ Vdom.Attr.class_ "posts-list" ]
          (List.map posts ~f:post_card)
      ]
  in
  Vdom.Node.create
    "section"
    ~attrs:[ Vdom.Attr.class_ "blog-page" ]
    (Vdom.Node.h1 ~attrs:[ Vdom.Attr.class_ "section-title" ] [ Vdom.Node.text "Blog" ]
     :: Vdom.Node.div
          ~attrs:[ Vdom.Attr.class_ "blog-controls" ]
          [ Vdom.Node.input
              ~attrs:
                [ Vdom.Attr.type_ "text"
                ; Vdom.Attr.class_ "search-input"
                ; Vdom.Attr.placeholder "Search posts..."
                ; Vdom.Attr.value_prop query
                ; Vdom.Attr.on_input (fun _ s -> set_query s)
                ]
              ()
          ; Ui.sort_button store sort
          ]
     :: body)
;;
