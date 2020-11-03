#!/bin/bash

#/**
# * repair snap
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

# if snap showing "snap-confine has elevated permissions and is not confined but should be. Refusing to continue to avoid permission escalation attacks"
# sudo snap refresh core --beta

# remove snap
echo_info 'sudo apt-get remove --assume-yes snapd'
sudo apt-get remove --assume-yes snapd

echo_info 'sudo apt-get purge --assume-yes snapd snap-confine'
sudo apt-get purge --assume-yes snapd snap-confine

# list installed apps
# sudo snap list
