# lecture-MPRI-2.4-monads: teacher version

## Setup

Install [Opam](https://opam.ocaml.org/doc/Install.html), the OCaml
package manager, on your system. If you have never used Opam before,
you need to initialize it (otherwise, skip this step):

```
$ opam init
```

For convenience, we suggest setting a
[local](https://opam.ocaml.org/blog/opam-local-switches/) Opam
distribution, using the following commands:

```
$ opam switch create . --deps-only --with-doc --with-test
$ eval $(opam env)
```

## Development

Once your programming environment is setup, you can build the project with

```
$ dune build
```

You can also build and run the test suite with

```
$ dune runtest
```

If you want to run individual tests, use

```
./runtest.sh exercices/Bank.ml
```

to only run the inline tests in the file `exercices/Bank.ml`, or

```
./runtest.sh exercices/Bank.ml:60
```

to only run the inline test defined at line 60 in the file
`exercices/Bank.ml`.
