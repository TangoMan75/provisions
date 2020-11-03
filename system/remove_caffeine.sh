#!/bin/bash

#/**
# * caffeine
# * avoids system going to sleep when watching videos
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get purge --assume-yes caffeine'
sudo apt-get purge --assume-yes caffeine

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

