#!/bin/bash

#/**
# * systemd-container
# *
# * @category devops
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes libpam-systemd systemd-container'
sudo apt-get install --assume-yes libpam-systemd systemd-container
