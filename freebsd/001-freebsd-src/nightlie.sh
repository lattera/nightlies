#!/usr/bin/env zsh

dataset="rpool/src/freebsd"

directory=$(zfs get -H -ovalue mountpoint ${dataset})

cd ${directory}

git fetch upstream
git merge upstream/master

git push origin master
