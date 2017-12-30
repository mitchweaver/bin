#!/bin/sh

# http://github.com/MitchWeaver/bin

function optimize() {
  jpegoptim *.jpg --strip-all
  for i in *
  do
    if test -d "$i"
    then
      cd "$i"
      optimize
      cd ..
    fi
  done
}

optimize
