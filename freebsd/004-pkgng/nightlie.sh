#!/usr/bin/env zsh

jails=("90amd64")
configdir="/tank/poudriere/configs"
portstree="local"

if [ ${portstree} = "default" ]; then
    sudo poudriere ports -u
fi

for j in ${jails}; do
    sudo poudriere bulk -f ${configdir}/${j}.ports.txt -j ${j} -p ${portstree}
done
