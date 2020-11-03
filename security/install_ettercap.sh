#!/bin/bash

#/**
# * ettercap
# *
# * Man in the middle attack suite
# *
# * @category security
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes ettercap-common ettercap-graphical'
sudo apt-get install --assume-yes ettercap-common ettercap-graphical

