#!/bin/bash

#/**
# * openvpn
# *
# * @category security
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes openvpn'
sudo apt-get install --assume-yes openvpn

echo_info 'sudo apt-get install --assume-yes network-manager-openvpn-gnome'
sudo apt-get install --assume-yes network-manager-openvpn-gnome
