(* sujet
(* Once you are done writing the code, remove this directive,
   whose purpose is to disable several warnings. *)
[@@@warning "-27-32-33-37-39"]
  /sujet *)

module Make (Env: sig
                 type t
                 val init : t
               end) = struct

  module Base = struct

    type 'a t = Env.t -> 'a

    (* sujet 
    let return a = failwith "NYI"

    let bind m f = failwith "NYI"
       /sujet *)

    (* corrige *)
    let return x = fun _ -> x
    let bind m f = fun e -> f (m e) e
    (* /corrige *)
  end

  module M = Monad.Expand(Base)
  include M

  (* sujet 
  let get () = failwith "NYI"

  let run m = failwith "NYI"
     /sujet *)

  (* corrige *)
  let get () = fun e -> e

  let run m = m Env.init
  (* /corrige *)

end
