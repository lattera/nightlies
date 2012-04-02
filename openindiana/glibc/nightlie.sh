#!/usr/bin/bash

cd ${HOME}/gitpush/glibc

git fetch upstream
git merge upstream/master
git push github
