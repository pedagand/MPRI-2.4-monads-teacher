# lecture-MPRI-2.4-monads: student version

## Setup

This project needs `dune` and `ppx_inline_test` to build. You can get
them through

    opam install dune.2.7 ppx_inline_test

KNOWN ISSUE: the integration of `ppx_inline_test` and merlin is known
to cause problem if you're using `ocaml-migrate-parsetree > 1.8.0`. Do

    opam install ocaml-migrate-parsetree.1.8.0

to resolve this issue (and restart merlin).

## Development

Once your programming environment is setup, you can build the project with

    dune build

You can also build and run the test suite with

    dune runtest

If you want to run individual tests, use

    ./runtest.sh exercices/Bank.ml

to only run the inline tests in the file `exercices/Bank.ml`, or

    ./runtest.sh exercices/Bank.ml:60

to only run the inline test defined at line 60 in the file
`exercices/Bank.ml`.

## Order of business

Your host suggests that you complete the exercises in the following
order:
  1. `lib/Error.ml`
  1. `exercises/Interpreter.ml`
  1. `lib/State.ml`
  1. `exercises/ParsingGame.ml`
  1. `lib/Nondeterminism.ml`
  1. `exercises/Permutations.ml`
  1. Need practice? `lib/Parser.ml`
  1. Need practice? `exercises/PidMaps.ml`
  1. `lib/Continuation.ml`
  1. `exercises/Height.ml`
  1. `exercises/Logic.ml`
  1. `lib/Reader.ml`
  1. `lib/Writer.ml`
  1. `exercises/Logger.ml`
  1. `lib/Update.ml`
  1. `exercises/Bank.ml`
  1. `exercises/Dice.ml`
  1. `exercises/Writer.ml`
  1. `exercises/Reader.ml`
