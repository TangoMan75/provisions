#!/bin/bash

#/**
# * clamav
# *
# * Virus scanner
# *
# * @category security
# * @link     https://doc.ubuntu-fr.org/clamav
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes clamav'
sudo apt-get install --assume-yes clamav

echo_info 'sudo apt-get install --assume-yes clamtk'
sudo apt-get install --assume-yes clamtk
