open! Core

type t =
  | Newest
  | Oldest

let equal a b =
  match a, b with
  | Newest, Newest | Oldest, Oldest -> true
  | Newest, Oldest | Oldest, Newest -> false
;;

let sexp_of_t = function
  | Newest -> Sexp.Atom "newest"
  | Oldest -> Sexp.Atom "oldest"
;;

let t_of_sexp = function
  | Sexp.Atom "newest" -> Newest
  | Sexp.Atom "oldest" -> Oldest
  | s -> raise_s [%message "Sort.t_of_sexp: unexpected sexp" (s : Sexp.t)]
;;

let toggle = function
  | Newest -> Oldest
  | Oldest -> Newest
;;

let label = function
  | Newest -> "Newest first"
  | Oldest -> "Oldest first"
;;

let is_newest = function
  | Newest -> true
  | Oldest -> false
;;
