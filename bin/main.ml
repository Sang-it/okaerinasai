open! Core
open! Bonsai_web

let () = Bonsai_web.Start.start ~bind_to_element_with_id:"app" Portfolio.App.component
