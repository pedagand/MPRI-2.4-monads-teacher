open Monads

(* Taken from
     Mesurer la hauteur d'un arbre
     Jean-Christophe Filliâtre
     https://hal.archives-ouvertes.fr/hal-02315541/
 *)

module M = Continuation.Make(struct type t = int end)
open M

type tree = E | N of tree * tree

let rec height = function
  | E -> 0
  | N (l, r) -> 1 + max (height l) (height r)

let make_list =
  let rec help acc n =
    if n <= 0 then acc
    else help (N (acc, E)) (n-1)
  in
  help E

let%test _ =
  let res = try height (make_list 1000000) with | _ -> -1
  in res = -1

(* XXX: this is a real bummer *)
(* https://discuss.ocaml.org/t/what-is-the-use-of-continuation-passing-style-cps/4491/16 *)
let rec hcpsauxnaive (t: tree) : int t = match t with
  | E -> return 0
  | N (l, r) -> let* hl = hcpsauxnaive l in
                let* hr = hcpsauxnaive r in
                return (1 + max hl hr)

let hcpsnaive t = run (hcpsauxnaive t)

let%test _ = hcpsnaive E = 0
let%test _ = hcpsnaive (N (E, E)) = 1
let%test _ = hcpsnaive (make_list 100) = 100
let%test _ = hcpsnaive (make_list 10000) = 10000
let%test _ =
  let res = try hcpsnaive (make_list 1000000) with _ -> -1
  in res = -1

let hcpsaux hcpsrec (t: tree) : int t = match t with
  | E -> return 0
  | N (l, r) -> let* hl = hcpsrec l in
                let* hr = hcpsrec r in
                return (1 + max hl hr)

let hcpsaux = tfix hcpsaux

let hcps t = run (hcpsaux t)

let%test _ = hcps E = 0
let%test _ = hcps (N (E, E)) = 1
let%test _ = hcps (make_list 100) = 100
let%test _ = hcps (make_list 10000) = 10000
let%test _ = hcps (make_list 1000000) = 1000000
