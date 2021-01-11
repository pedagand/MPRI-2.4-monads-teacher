module Make (Ans: 
               sig
                 type t
               end) = struct

  module Base = struct
    type 'a t = ('a -> Ans.t) -> Ans.t

    let return a k = k a

    let bind m f k = m (fun v -> (f v) k)

  end

  module M = Monad.Expand (Base)
  include M
  open Base

  let callcc (f: ('a -> Ans.t) -> Ans.t) = fun k -> f (fun v -> k v)

  let throw x k' = fun _ -> x k'

  let rec tfix (m: ('a -> 'b t) -> ('a -> 'b t))(a: 'a) : 'b t =
    (* XXX: it seems that I need to eta-expand here or it will not do tailrec, why? *)
    fun k -> m (tfix m) a k

  let run (m: Ans.t t) = m (fun x -> x)

end
