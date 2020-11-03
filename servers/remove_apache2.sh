#!/bin/bash

#/**
# * remove apache2
# *
# * @category servers
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get purge --assume-yes apache2'
sudo apt-get purge --assume-yes apache2

echo_info 'sudo rm -rf /var/lib/apache2'
sudo rm -rf /var/lib/apache2

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

