#!/bin/bash

#/**
# * openssh-server
# * secure shell protocol
# *
# * Start ssh server
# * sudo systemctl start ssh
# * 
# * Stop ssh server
# * sudo systemctl stop ssh
# * 
# * Restart ssh server
# * sudo systemctl restart ssh
# *
# * @category servers
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes openssh-server'
sudo apt-get install --assume-yes openssh-server

