open Monads

(* Taken from https://chrispenner.ca/posts/update-monad *)

module Transaction = struct
  type t
    = Deposit of int * t
    | Withdraw of int * t
    | ApplyInterest of t
    | EndOfTransaction

  let empty = EndOfTransaction

  (* XXX: not tail rec *)
  let rec (<+>) t1 t2 =
    match t1 with
    | Deposit (i, t1) -> Deposit (i, t1 <+> t2)
    | Withdraw (i, t1) -> Withdraw (i, t1 <+> t2)
    | ApplyInterest t1 -> ApplyInterest (t1 <+> t2)
    | EndOfTransaction -> t2
end

module State = struct
  open Transaction

  type t = int

  let init = 0

  (* TODO: should use an integral representation instead: manipulate 'balance * 100' *)
  let computeInterest balance = int_of_float (float_of_int balance *. 1.1)

  let rec act balance = function
    | EndOfTransaction -> balance
    | Deposit (i, t) -> act (balance + i) t
    | Withdraw (i, t) -> act (balance - i) t
    | ApplyInterest t -> act (computeInterest balance) t

end

module M = Update.Make(Transaction)(State)
open M
open Transaction

let deposit s = set (Deposit (s, EndOfTransaction))
let withdraw s = set (Withdraw (s, EndOfTransaction))
let applyInterest = set (ApplyInterest EndOfTransaction)

let useATM =
  let* _ = deposit 20 in
  let* _ = deposit 30 in
  let* _ = applyInterest in
  let* _ = withdraw 10 in
  get ()

let%test _ =
  let (receipt, balance) = run useATM in
  balance = 45 &&
    receipt = Deposit (20, Deposit (30, ApplyInterest (Withdraw (10, EndOfTransaction))))
