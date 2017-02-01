#!/bin/sh
set -ex
DST="$1"
if [ -z "$DST" ]; then
    echo "Missing destination directory argument"
    exit 1
fi
PATH="$HOME/Qt/binary/5.6.0/5.6/gcc_64/bin:$PATH"
export PATH
./configure "--prefix=$DST"
make -C src install
make -C tools install
