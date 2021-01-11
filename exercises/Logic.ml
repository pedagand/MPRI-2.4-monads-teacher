open Monads

type bot = |
module M = Continuation.Make(struct type t = bot end)
open M

let exfalso () =
  callcc (fun k -> k (Error (fun a -> k (Ok a))))
