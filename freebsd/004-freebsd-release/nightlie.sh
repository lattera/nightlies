#!/usr/local/bin/bash

KERNCONF=SEC

set -e
cd /usr/src/release

cd /usr/src
make -j4 buildworld
make -j4 buildkernel KERNCONF=${KERNCONF}

sudo make clean
sudo make NOPORTS=1 NODOC=1 NOSRC=1 KERNCONF=${KERNCONF} MAKE_FLAGS=-j4 release
