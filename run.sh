#!/usr/bin/env bash

date=`/bin/date '+%F_%T'`
env=""
debugging="false"

cd `dirname "$0"`

if [ -f "env.txt"  ]; then
    env=`cat env.txt`
else
    echo "Please place environment in env.txt"
    exit 0
fi

if [ -f "debug" ]; then
    debugging="true"
fi

for line in `find $env -name nightlie.sh`; do
    if [ "$debugging" == "false" ]; then
        # Use one log file per nightly
        logfile=`echo $line | sed 's/\//_/g'`
        exec 1> logs/$date-$logfile.log
        exec 2>&1
    fi

    echo "[+] Executing $line"
    if [ "$debugging" == "false" ]; then
        $line
    fi
done
