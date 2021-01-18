open Monads
open Monoid

module Make (Log: Monoid) = struct

  (* sujet
  (* Use the Update monad to instantiate the following definitions *)

  type 'a t = | (* NYI: bring me in scope! *)

  let return _ = failwith "NYI: bring me in scope!"

  let bind _ _ = failwith "NYI: bring me in scope!"

  let ( >>= ) _ _ = failwith "NYI: bring me in scope!"

  let ( let* ) _ _ = failwith "NYI: bring me in scope!"

  let set _ = failwith "NYI: bring me in scope!"

  let run _ = failwith "NYI: bring me in scope!"

     /sujet *)

  (* corrige *)
  module A = struct
    type t = unit
    type m = Log.t

    let act _ _ = ()
  end

  module M = Update.Make(Log)(A)
  include M

  let run a = M.run a ()
  (* /corrige *)

end
