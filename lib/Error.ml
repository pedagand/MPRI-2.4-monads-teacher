(* sujet
(* Once you are done writing the code, remove this directive,
   whose purpose is to disable several warnings. *)
[@@@warning "-27-32-33-37-39"]
  /sujet *)

module Base = struct
  type 'a t =
    | Val of 'a
    | Err of exn

  (* sujet 
  let return a = failwith "NYI"

  let bind m f = failwith "NYI"
     /sujet *)

  (* corrige *)
  let return a = Val a

  let bind m f = match m with Err e -> Err e | Val x -> f x
  (* /corrige *)
end

module M = Monad.Expand (Base)
include M
open Base

(* sujet 
let err e = failwith "NYI"

let try_with_finally m ks kf = failwith "NYI"

let run m = failwith "NYI"
   /sujet *)

(* corrige *)
let err e = Err e

let try_with_finally m ks kf = match m with Val x -> ks x | Err e -> kf e

let run m = match m with Val x -> x | Err _ -> failwith "Uncaught exception"
(* /corrige *)
