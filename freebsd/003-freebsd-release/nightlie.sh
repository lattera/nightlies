#!/usr/bin/env zsh

KERNCONF=SEC
JOBS=7

set -e

cd /usr/src
make -sj${JOBS} buildworld buildkernel KERNCONF=${KERNCONF}

cd /usr/src/release
sudo make clean
sudo make NOPORTS=1 NODOC=1 NOSRC=1 KERNCONF=${KERNCONF} release
