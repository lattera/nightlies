#!/usr/bin/env zsh

cd /usr/ports
git fetch
git merge origin/master

make -j7 index
