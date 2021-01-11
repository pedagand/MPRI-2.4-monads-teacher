
(* XXX: straightforward implementation is List, obviously *)

module Base = struct
  type 'a t = 'a Seq.t

  let return a = Seq.return a

  let bind m f = Seq.flat_map f m
end

module M = Monad.Expand (Base)
include M

let fail () = Seq.empty
let either a b = Seq.append a b

let run m =
  match m () with
  | Seq.Nil -> failwith "Empty"
  | Seq.Cons (a, _) -> a
let all m = m
