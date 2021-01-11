module type Monoid = sig
  type t
  val empty : t
  val ( <+> ) : t -> t -> t
end
