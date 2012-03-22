#!/usr/local/bin/bash

git_remote_url="git@github.com:lattera/freebsd-ports.git"
git_remote_name="github"

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

if [ -d ${git_directory}/.git ]; then
    # Recreate the git repo from scratch
    cd ${git_directory}
    find . -depth 1 -print0 | xargs -0 rm -rf

    git init
    git remote add ${git_remote_name} ${git_remote_url}
    cd ${base_directory}
fi

csup -L2 ${supfile}
cvscvt -e freebsd.org -k FreeBSD ${cvsroot_directory}/ports | GIT_DIR=${git_directory}/.git git fast-import

cd ${git_directory}
git fetch ${git_remote_name}

if [ -f .cvsignore ]; then
    rm .cvsignore
fi

git pull ${git_remote_name} master
git push ${git_remote_name}
