module Base = struct
  type 'a t =
    | Val of 'a
    | Err of exn

  let return a = Val a

  let bind m f = match m with Err e -> Err e | Val x -> f x
end

module M = Monad.Expand (Base)
include M
open Base

let err e = Err e

let try_with_finally m ks kf = match m with Val x -> ks x | Err e -> kf e

let run m = match m with Val x -> x | Err _ -> failwith "Uncaught exception"
