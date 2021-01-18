(* sujet
(* Once you are done writing the code, remove this directive,
   whose purpose is to disable several warnings. *)
[@@@warning "-27-32-33-37-39"]
  /sujet *)

module Base = struct
  type 'a res =
    | Val of 'a * char list
    | Err

  type 'a t = char list -> 'a res

  (* sujet
     let return a = failwith "NYI"

     let bind m f = failwith "NYI"
        /sujet *)

  (* corrige *)
  let return x toks = Val (x, toks)

  let bind m f toks =
    match m toks with Err -> Err | Val (x, toks') -> f x toks'

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
let fail () _ = Err

let any () = function [] -> Err | c :: toks' -> Val (c, toks')

let empty () = function [] -> Val ((), []) | _ -> Err

let either m1 m2 toks =
  match m1 toks with Err -> m2 toks | Val (_, _) as res -> res


let run m toks =
  match m toks with Err -> failwith "Invalid input" | Val (x, _) -> x

(* /corrige *)

(* TODO: add a backtracking operator? *)
