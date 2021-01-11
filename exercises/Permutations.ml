open Monads.Nondeterminism

let rec insert x l =
  either
    (return (x :: l))
    (match l with
     | [] -> fail ()
     | hd :: tl ->
        let* l' = insert x tl in
        return (hd :: l'))

let rec permut l =
  match l with
  | [] -> return []
  | hd :: tl ->
     let* l' = permut tl in
     insert hd l'

let%test _ = List.of_seq (all (permut [])) = [[]]
let%test _ = List.of_seq (all (permut [1])) = [[1]]
let%test _ = List.sort compare (List.of_seq (all (permut [1; 2]))) = [[1; 2]; [2; 1]]
let%test _ = List.sort compare (List.of_seq (all (permut [1; 2; 3]))) = [[1;2;3]; [1;3;2]; [2;1;3]; [2;3;1]; [3;1;2]; [3;2;1]]
