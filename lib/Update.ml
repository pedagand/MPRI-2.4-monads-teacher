open Monoid

(* sujet
(* Once you are done writing the code, remove this directive,
   whose purpose is to disable several warnings. *)
[@@@warning "-27-32-33-37-39"]
  /sujet *)

module Make
         (P: Monoid)
         (S: MonoidAction with type m = P.t) = struct

  module Base = struct
    open P
    open S

    type 'a t = S.t -> P.t * 'a

    (* sujet 
    let return a = failwith "NYI"

    let bind m f = failwith "NYI"
       /sujet *)

    (* corrige *)
     let return x = fun _ -> (P.empty, x)

    let bind m f = fun s ->
      let (p1, r1) = m s in
      let (p2, r2) = f r1 (act s p1) in
      (p1 <+> p2, r2)
    (* /corrige *)

  end

  module M = Monad.Expand (Base)
  include M

  (* sujet 
  let get () = failwith "NYI"

  let set p = failwith "NYI"

  let run m = failwith "NYI"
   /sujet *)

  (* corrige *)
  let get () = fun s -> (P.empty, s)

  let set p = fun _ -> (p, ())

  let run m = m S.init
  (* /corrige *)

end
