#!/bin/bash

#/**
# * remove bloat libre office
# *
# * @category office
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get purge --assume-yes libreoffice-draw'
sudo apt-get purge --assume-yes libreoffice-draw

echo_info 'sudo apt-get purge --assume-yes libreoffice-impress'
sudo apt-get purge --assume-yes libreoffice-impress

echo_info 'sudo apt-get purge --assume-yes libreoffice-math'
sudo apt-get purge --assume-yes libreoffice-math

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

