module Make (Log: sig
                 type t
                 val empty : t
                 val (<+>) : t -> t -> t
               end) = struct

  open Log

  module Base = struct

    type 'a t = Log.t * 'a

    let return x = (empty, x)
    let bind m f =
      let (l1, r1) = m in
      let (l2, r2) = f r1 in
      (l1 <+> l2, r2)

  end

  module M = Monad.Expand (Base)
  include M

  let set l = (l, ())

  let run m = m

end
