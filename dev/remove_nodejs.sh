#!/bin/bash

#/**
# * remove nodejs
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

# uninstall nodejs
echo_caption 'uninstall nodejs'

echo_info 'sudo apt-get purge --assume-yes yarn'
sudo apt-get purge --assume-yes yarn

echo_info 'sudo apt-get purge --assume-yes npm'
sudo apt-get purge --assume-yes npm

echo_info 'sudo apt-get purge --assume-yes nodejs'
sudo apt-get purge --assume-yes nodejs

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

