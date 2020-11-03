#!/bin/bash

#/**
# * install tlp
# * Enable power saving features
# * Edit settings here: /etc/default/tlp
# * Then reboot or `sudo tlp start`
# * You may also want the packages *"thermald"*, *"lm-sensors"* and *"psensor"*
# * https://doc.ubuntu-fr.org/tlp
# *
# * @category system
# * @link     https://erdnaxe.github.io/dell-g3-17-ubuntu
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes tlp'
sudo apt-get install --assume-yes tlp

echo_info 'sudo apt-get install --assume-yes tlp-rdw'
sudo apt-get install --assume-yes tlp-rdw

echo_info 'sudo systemctl enable tlp'
sudo systemctl enable tlp

echo_info 'sudo systemctl enable tlp-sleep'
sudo systemctl enable tlp-sleep

echo_info 'sudo tlp start'
sudo tlp start
