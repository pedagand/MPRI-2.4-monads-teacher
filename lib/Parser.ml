(* sujet
(* Once you are done writing the code, remove this directive,
   whose purpose is to disable several warnings. *)
[@@@warning "-27-32-33-37-39"]
  /sujet *)

module Base = struct

  type 'a res =
    | Val of 'a * char list
    | Err
  type 'a t = char list -> 'a  res

  (* sujet 
  let return a = failwith "NYI"

  let bind m f = failwith "NYI"
     /sujet *)

  (* corrige *)
  let return x = fun toks -> Val (x, toks)

  let bind m f =
    fun toks ->
    match m toks with
    | Err -> Err
    | Val (x, toks') -> f x toks'
  (* /corrige *)

end

module M = Monad.Expand (Base)
include M
open Base

(* sujet
let fail () = failwith "NYI"

let any () = failwith "NYI"

let empty () = failwith "NYI"

let symbol c = failwith "NYI"

let either m1 m2 = failwith "NYI"

let optionally m = failwith "NYI"

let rec star m = failwith "NYI"
and plus m = failwith "NYI"

let run m toks = failwith "NYI"
 /sujet *)

(* corrige *)
let fail () = fun _ -> Err

let any () = function
  | [] -> Err
  | c :: toks' -> Val (c, toks')

let empty () = function
  | [] -> Val((), [])
  | _ -> Err

let symbol c =
   fun toks ->
      match toks with
      | c' :: toks' when c' = c -> Val((), toks')
      | _ -> Err


let either m1 m2 =
  fun toks ->
  match m1 toks with
  | Err -> m2 toks
  | Val(_, _) as res -> res

let optionally m =
  either
    (let* x = m in return (Some x))
    (return None)

let rec star m =
  either
    (plus m)
    (return [])
and plus m =
  let* x = m in
  let* y = star m in
  return (x :: y)

let run m toks = match m toks with
  | Err -> failwith "Invalid input"
  | Val (x, _) -> x
(* /corrige *)

(* TODO: add a backtracking operator? *)
