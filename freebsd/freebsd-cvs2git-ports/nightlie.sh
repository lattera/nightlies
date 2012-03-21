#!/usr/local/bin/bash

# Abstract the directories so that they can be mounted anywhere
base_dataset="rpool/ports_cvs"
cvsroot_dataset="cvsroot"
git_dataset="gitrepo"
supfile="cvs-supfile"

base_directory=`zfs get -H -ovalue mountpoint ${base_dataset}`
cvsroot_directory=`zfs get -H -ovalue mountpoint ${base_dataset}/${cvsroot_dataset}`
git_directory=`zfs get -H -ovalue mountpoint ${base_dataset}/${git_dataset}`

cd ${base_directory}

if [ ! -f ${supfile} ]; then
    echo "Please place ${supfile} in ${base_directory}"
    exit 1
fi

if [ ! -d ${git_directory}/.git ]; then
    (cd ${git_directory}; git init)
fi

csup -L2 ${supfile}
cvscvt -e freebsd.org -k FreeBSD ${cvsroot_directory}/ports | GIT_DIR=${git_directory}/.git git fast-import

cd ${git_directory}
git reset --hard HEAD
git push github
