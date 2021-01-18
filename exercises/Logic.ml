(* sujet
(* Once you are done writing the code, remove this directive,
   whose purpose is to disable several warnings. *)
[@@@warning "-27-32-33-37-39"]
  /sujet *)

open Monads

type bot = |

type 'a not = 'a -> bot

module M = Continuation.Make (struct
  type t = bot
end)

open M

(* sujet
let exfalso () = failwith "NYI"
   /sujet *)

(* corrige *)
let bot_elim (b : bot) = match b with _ -> .

let exfalso () = callcc (fun k -> bot_elim (k (Error (fun a -> k (Ok a)))))

(* /corrige *)
