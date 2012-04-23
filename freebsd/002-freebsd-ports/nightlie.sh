#!/usr/local/bin/bash

cd /usr/ports
git fetch upstream
git merge upstream/master

make index
