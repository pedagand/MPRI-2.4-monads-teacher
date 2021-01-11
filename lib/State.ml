module Make (S: sig 
                 type t
                 val init : t
               end) = struct

  module State = struct
    type 'a t = S.t -> 'a * S.t

    let return a s = (a, s)

    let bind m f s = match m s with x, s' -> f x s'
  end

  module M = Monad.Expand (State)
  include M

  let get () s = (s, s)

  let set x _ = ((), x)
            
  let run m = match m S.init with x, _ -> x

end
