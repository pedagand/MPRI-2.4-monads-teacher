open Monads.Parser

val oneOf : char list -> char t
val hexDigit : char t
val hexNumber : string t
val parseAddress : (string * string) t
val parsePerms : (bool * bool * bool * char) t
val parseDevice : (string * string) t
val parsePath : string t
val parseRegion : ((string * string) * (bool * bool * bool * char) * string * (string * string) * string * string) t
