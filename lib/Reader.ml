module Make (Env: sig
                 type t
                 val init : t
               end) = struct

  module Base = struct

    type 'a t = Env.t -> 'a

    let return x = fun _ -> x
    let bind m f = fun e -> f (m e) e

  end

  let get () = fun e -> e

  let run m = m Env.init

end
