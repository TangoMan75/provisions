#!/bin/bash

#/**
# * remove php-xdebug
# * php debug plugin
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get purge --assume-yes php-xdebug'
sudo apt-get purge --assume-yes php-xdebug

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

