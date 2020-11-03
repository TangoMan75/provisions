#!/bin/bash

#/**
# * lxd-client
# * manage LXC (linux container)
# *
# * @category devops
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes lxd lxd-client'
sudo apt-get install --assume-yes lxd lxd-client
