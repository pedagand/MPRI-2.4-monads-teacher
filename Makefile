DST  := ../lecture-MPRI24-monads-public
ROOT := dune-project runtest.sh
SRC  := $(shell git ls-files lib/ exercises/)

.PHONY: export
export:
# Make sure everything compiles.
	@ dune runtest
# Recreate the destination directory from scratch.
	@ rm -rf $(DST)
	@ mkdir $(DST) $(DST)/lib $(DST)/exercises
# Copy the files that must reside at the root.
	@ cp $(ROOT) $(DST)
# Copy the source files.
	@ for f in $(SRC) ; do \
	  sed -f sanitize.sed $$f > $(DST)/$$f ; \
	done
# Compile the code that is given to the students.
	@ cd $(DST); dune build
# Show what we have done.
	ls $(DST) $(DST)/lib $(DST)/exercises
