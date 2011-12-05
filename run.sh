#!/usr/local/bin/bash

for line in `find . -name nightlie.sh`; do
    echo "[+] Executing $line"
    exec $line
done
