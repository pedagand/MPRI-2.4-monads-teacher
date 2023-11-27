(* sujet
   (* Once you are done writing the code, remove this directive,
      whose purpose is to disable several warnings. *)
   [@@@warning "-27-32-33-37-39"]
     /sujet *)

module Make (S : sig
  type t
end) =
struct
  module State = struct
    type 'a t = S.t -> 'a * S.t

    (* sujet
       let return a = failwith "NYI"

       let bind m f = failwith "NYI"
        /sujet *)

    (* corrige *)
    let return a s = (a, s)
    let bind m f s = match m s with x, s' -> f x s'

    (* /corrige *)
  end

  module M = Monad.Expand (State)
  include M

  (* sujet
     let get () s = failwith "NYI"

     let set x _ = failwith "NYI"

     let run m = failwith "NYI"
      /sujet *)

  (* corrige *)
  let get () s = (s, s)
  let set x _ = ((), x)
  let run m s0 = match m s0 with x, _ -> x

  (* /corrige *)
end
