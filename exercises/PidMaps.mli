open Monads.Parser

(* Library combinators *)

val symbol : char -> unit t
val oneOf : char list -> char t
val star : 'a t -> 'a list t
val plus : 'a t -> 'a list t

(* Parser *)

val hexDigit : unit -> char t
val hexNumber : unit -> string t
val parseAddress : unit -> (string * string) t
val parsePerms : unit -> (bool * bool * bool * char) t
val parseDevice : unit -> (string * string) t
val parsePath : unit -> string t
val parseRegion : unit -> ((string * string) * (bool * bool * bool * char) * string * (string * string) * string * string) t
