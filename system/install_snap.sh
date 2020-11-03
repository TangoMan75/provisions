#!/bin/bash

#/**
# * snap
# * app library
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt install -y snapd'
sudo apt install -y snapd

# if snap showing "snap-confine has elevated permissions and is not confined but should be. Refusing to continue to avoid permission escalation attacks"
# sudo snap refresh core --beta

# list installed apps
# sudo snap list
