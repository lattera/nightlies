#!/usr/local/bin/bash

cd /usr/ports
git fetch upstream
git merge upstream/master
git push github

make index
