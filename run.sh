#!/usr/bin/env bash

date=`/bin/date '+%F_%T'`
env=""
debugging="false"

cd `dirname "$0"`

if [ -f "env.txt"  ]
then
    env=`cat env.txt`
else
    echo "Please place environment in env.txt"
    exit 0
fi

if [ -f "debug" ]
then
    debugging="true"
fi

exec 1> logs/$date
exec 2>&1

for line in `find $env -name nightlie.sh`; do
    echo "[+] Executing $line"
    if [ "$debugging" = "false" ]; then
        exec $line
    fi
done
