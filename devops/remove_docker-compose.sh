#!/bin/bash

#/**
# * remove docker-compose
# *
# * @category devops
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo rm -f /usr/bin/docker-compose'
sudo rm -f /usr/bin/docker-compose

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

