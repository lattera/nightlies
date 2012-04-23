#!/usr/local/bin/bash

cd /usr/src/release
sudo make clean
sudo make NOPORTS=1 NODOC=1 NOSRC=1 KERNCONF=SEC MAKE_FLAGS=-j4 release
