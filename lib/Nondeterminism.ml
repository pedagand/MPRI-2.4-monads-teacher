(* sujet
(* Once you are done writing the code, remove this directive,
   whose purpose is to disable several warnings. *)
[@@@warning "-27-32-33-37-39"]
  /sujet *)

module Base = struct
  (* sujet
     type 'a t = 'a list
        /sujet *)
  (* corrige *)
  (* TODO: straightforward implementation is List, obviously *)
  type 'a t = 'a Seq.t

  (* /corrige *)

  (* sujet
     let return a = failwith "NYI"

     let bind m f = failwith "NYI"
        /sujet *)

  (* corrige *)
  let return a = Seq.return a

  let bind m f = Seq.flat_map f m

  (* /corrige *)
end

module M = Monad.Expand (Base)
include M

(* sujet 
let fail () = failwith "NYI"

let either a b = failwith "NYI"

let run m = failwith "NYI"

let all m = failwith "NYI"
   /sujet *)

(* corrige *)
let fail () = Seq.empty

let either a b = Seq.append a b

let run m = match m () with Seq.Nil -> failwith "Empty" | Seq.Cons (a, _) -> a

let all m = m

(* /corrige *)
