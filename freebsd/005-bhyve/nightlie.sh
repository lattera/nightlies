#!/usr/local/bin/bash

dataset="rpool/src/bhyve"
directory=$(zfs get -H -ovalue mountpoint ${dataset})

cd ${directory}
git svn rebase
git push github
