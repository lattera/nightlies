#!/usr/local/bin/bash

cd /src
git fetch upstream
git merge upstream/svn_stable_9
git push github
