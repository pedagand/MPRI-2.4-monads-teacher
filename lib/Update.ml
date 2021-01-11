module type Monoid = sig
         type t
         val empty : t
         val ( <+> ) : t -> t -> t
       end

module Make
         (P: Monoid)
         (S: sig
              type t
              val init : t
              val act : t -> P.t -> t
            end) = struct

  module Base = struct
    open P
    open S

    type 'a t = S.t -> P.t * 'a

    let return x = fun _ -> (P.empty, x)

    let bind m f = fun s ->
      let (p1, r1) = m s in
      let (p2, r2) = f r1 (act s p1) in
      (p1 <+> p2, r2)

  end

  module M = Monad.Expand (Base)
  include M

  let get () = fun s -> (P.empty, s)

  let set p = fun _ -> (p, ())

  let run m = m S.init

end
