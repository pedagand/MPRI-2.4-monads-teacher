(* sujet
(* Once you are done writing the code, remove this directive,
   whose purpose is to disable several warnings. *)
[@@@warning "-27-32-33-37-39"]
  /sujet *)

module Make (Ans: 
               sig
                 type t
               end) = struct

  module Base = struct
    type 'a t = ('a -> Ans.t) -> Ans.t

    (* sujet 
    let return a = failwith "NYI"

    let bind m f = failwith "NYI"
       /sujet *)

    (* corrige *)
    let return a k = k a

    let bind m f k = m (fun v -> (f v) k)
    (* /corrige *)
  end

  module M = Monad.Expand (Base)
  include M

  (* sujet 
  let callcc f = failwith "NYI"

  let throw m k' = failwith "NYI"

  let tfix mrec a = failwith "NYI"

  let run m = failwith "NYI"
     /sujet *)
     
  (* corrige *)
  let callcc f = fun k -> f k k

  let throw m k' = fun _ -> m k'

  let run m = m (fun x -> x)
  (* /corrige *)
                       
end
