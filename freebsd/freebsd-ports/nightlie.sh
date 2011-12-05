#!/usr/local/bin/bash

cd /usr/ports
sudo git fetch upstream
sudo git merge upstream/master
sudo git push github

sudo make index
