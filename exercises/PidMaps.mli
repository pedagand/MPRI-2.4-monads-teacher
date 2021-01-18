open Monads.Parser

(* Library combinators *)

val symbol : char -> unit t
val oneOf : char list -> char t
val star : 'a t -> 'a list t
val plus : 'a t -> 'a list t

(* Parser *)

val hexDigit : char t
val hexNumber : string t
val parseAddress : (string * string) t
val parsePerms : (bool * bool * bool * char) t
val parseDevice : (string * string) t
val parsePath : string t
val parseRegion : ((string * string) * (bool * bool * bool * char) * string * (string * string) * string * string) t
