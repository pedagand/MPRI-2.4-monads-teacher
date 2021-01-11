open Monoid

module Make
         (P: Monoid)
         (S: sig
              (* TODO: could I move this nicely into Monoid.ml? *)
              type t
              val init : t
              val act : t -> P.t -> t
            end) : sig

type 'a t 

(* Structure *)

val return : 'a -> 'a t

val bind : 'a t -> ('a -> 'b t) -> 'b t

val ( >>= ) : 'a t -> ('a -> 'b t) -> 'b t

val ( let* ) : 'a t -> ('a -> 'b t) -> 'b t (* à la ML *)

(* Operations *)

val get : unit -> S.t t

val set : P.t -> unit t

(* Runner *)

val run : 'a t -> P.t * 'a

end
