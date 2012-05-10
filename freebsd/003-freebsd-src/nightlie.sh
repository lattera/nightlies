#!/usr/local/bin/bash

dataset="rpool/src/freebsd"
branch="svn_stable_9"

directory=$(zfs get -H -ovalue mountpoint ${dataset})

cd ${directory}

curbranch=$(git branch | grep '*' | awk '{print $2;}')

git fetch upstream
git merge upstream/${curbranch}

if [ ! "${curbranch}" == "master" ]; then
    git checkout master
    git merge upstream/master
    git checkout ${curbranch}
fi

git push github
