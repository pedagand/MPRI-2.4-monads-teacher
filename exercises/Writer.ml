open Monads
open Monoid

module Make (Log: Monoid) = struct

  (* sujet
  (* Use the Update monad to instantiate the following definitions *)

  type 'a t = | (* NYI: bring me in scope! *)

  let return = failwith "NYI: bring me in scope!"

  let bind = failwith "NYI: bring me in scope!"

  let ( >>= ) = failwith "NYI: bring me in scope!"

  let ( let* ) = failwith "NYI: bring me in scope!"

  let set = failwith "NYI: bring me in scope!"

  let run = failwith "NYI: bring me in scope!"

     /sujet *)

  (* corrige *)
  module A = struct
    type t = unit
    type m = Log.t

    let init = ()
    let act _ _ = ()
  end

  module M = Update.Make(Log)(A)
  include M
  (* /corrige *)

end
