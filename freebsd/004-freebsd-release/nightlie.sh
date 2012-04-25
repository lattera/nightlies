#!/usr/local/bin/bash

KERNCONF=SEC

DATE=`date '+%F'`

set -e

cd /usr/src
make -j4 buildworld
make -j4 buildkernel KERNCONF=${KERNCONF}

cd /usr/src/release
sudo make clean
sudo make NOPORTS=1 NODOC=1 NOSRC=1 KERNCONF=${KERNCONF} MAKE_FLAGS=-j4 release

scp /usr/obj/src/release/release.iso www.0xfeedface.org:public_html/freebsd/nightlies/9-stable/${DATE}.iso
scp /usr/obj/src/release/memstick www.0xfeedface.org:public_html/freebsd/nightlies/9-stable/${DATE}.memstick.img
