open Monads

module M : Monad.Monad

type bot = |

val exfalso : unit -> ('a, 'a -> bot) result M.t
