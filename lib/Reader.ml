(* sujet
(* Once you are done writing the code, remove this directive,
   whose purpose is to disable several warnings. *)
[@@@warning "-27-32-33-37-39"]
  /sujet *)

module Make (Env : sig
  type t
end) =
struct
  module Base = struct
    type 'a t = Env.t -> 'a

    (* sujet
       let return a = failwith "NYI"

       let bind m f = failwith "NYI"
          /sujet *)

    (* corrige *)
    let return x _ = x

    let bind m f e = f (m e) e

    (* /corrige *)
  end

  module M = Monad.Expand (Base)
  include M

  (* sujet
     let get () = failwith "NYI"

     let local e m = failwith "NYI"

     let run m = failwith "NYI"
        /sujet *)

  (* corrige *)
  let get () e = e
  let local e m _ = m e
  let run m init = m init

  (* /corrige *)
end
