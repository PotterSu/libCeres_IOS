#!/bin/sh
rm -r build

mkdir build
cd build

set -e

current_dir=$(cd `dirname $0`; pwd)
echo $current_dir

export OUT_ROOT_DIR="$current_dir/libEigen"

cmake ..
make
make install DESTDIR=$OUT_ROOT_DIR
