(* sujet
   (* Once you are done writing the code, remove this directive,
      whose purpose is to disable several warnings. *)
   [@@@warning "-26-27-32-33-37-39"]
     /sujet *)

open Monads
open Random

module Example (M : ProbMonad) = struct
  open M

  let dice num_sides =
    let* n = rand num_sides in
    return (n + 1)

  let roll_3d6 =
    let* d1 = dice 6 in
    let* d2 = dice 6 in
    let* d3 = dice 6 in
    return (d1 + d2 + d3)
end

module E1 = Example (MonteCarlo)

(* sujet
   let%test _ =
     let r = MonteCarlo.run E1.roll_3d6 in
     failwith "NYI: write a meaningful test here"
      /sujet *)

(* corrige *)
let%test _ =
  let r = MonteCarlo.run E1.roll_3d6 in
  r >= 0 && r < 3 * 6

(* /corrige *)

module E2 = Example (Distribution)

let ( =~ ) p1 p2 =
  (* https://github.com/ocaml-batteries-team/batteries-included/blob/879c49663126702ce0388df4b0fb01303f184810/src/batFloat.ml *)
  abs_float (p1 -. p2) < 1e-5

(* sujet
   let%test _ =
     let r = Distribution.run E2.roll_3d6 in
     failwith "NYI: write a meaningful test here"
      /sujet *)

(* corrige *)
let roll_3d6_distr =
  [
    (3, 0.004630);
    (4, 0.013889);
    (5, 0.027778);
    (6, 0.046296);
    (7, 0.069444);
    (8, 0.097222);
    (9, 0.115741);
    (10, 0.125000);
    (11, 0.125000);
    (12, 0.115741);
    (13, 0.097222);
    (14, 0.069444);
    (15, 0.046296);
    (16, 0.027778);
    (17, 0.013889);
    (18, 0.004630);
  ]

let%test _ =
  List.for_all2
    (fun (x1, p1) (x2, p2) -> x1 = x2 && p1 =~ p2)
    (Distribution.run E2.roll_3d6)
    roll_3d6_distr

(* /corrige *)

module E3 = Example (Expectation)

(* sujet
   let%test _ =
     let r = Expectation.run E3.roll_3d6 in
     failwith "NYI: write a meaningful test here"
      /sujet *)

(* corrige *)
let%test _ =
  roll_3d6_distr
  |> List.for_all (fun (x, p) ->
         let k n =
           assert (n >= 3);
           assert (n <= 18);
           if n = x then 1. else 0.
         in
         Expectation.run E3.roll_3d6 k =~ p)

(* /corrige *)
