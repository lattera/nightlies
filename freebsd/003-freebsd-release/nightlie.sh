#!/usr/bin/env zsh

KERNCONF=SEC
JOBS=7
DATE=$(date '+%F_%T')

set -e

cd /usr/src
make -sj${JOBS} buildworld buildkernel KERNCONF=${KERNCONF}

cd /usr/src/release
sudo make clean

sudo make -s NOPORTS=1 NODOC=1 NOSRC=1 KERNCONF=${KERNCONF} release

ssh 0xfeedface.org 'rm -f /home/shawn/public_html/nightlies/freebsd/amd64/9-stable/* || true'
scp -C /usr/obj/usr/src/release/release.iso "0xfeedface.org:/home/shawn/public_html/nightlies/freebsd/amd64/9-stable/${DATE}-release.iso"
scp -C /usr/obj/usr/src/release/memstick "0xfeedface.org:/home/shawn/public_html/nightlies/freebsd/amd64/9-stable/${DATE}-memstick.img"
scp -C /usr/obj/usr/src/release/*.txz "0xfeedface.org:/home/shawn/public_html/nightlies/freebsd/pub/FreeBSD/snapshots/amd64/amd64/9.1-STABLE"
