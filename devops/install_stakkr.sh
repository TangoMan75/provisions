#!/bin/bash

#/**
# * stakkr
# *
# * @category devops
# * @link     https://docs.stakkr.org/en/latest/pages/installation.html
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes python3-pip'
sudo apt-get install --assume-yes python3-pip

echo_info 'sudo apt-get install --assume-yes python3-setuptools'
sudo apt-get install --assume-yes python3-setuptools

echo_info 'sudo apt-get install --assume-yes python3-virtualenv'
sudo apt-get install --assume-yes python3-virtualenv

echo_info 'sudo apt-get install --assume-yes python3-wheel'
sudo apt-get install --assume-yes python3-wheel

echo_info 'sudo python3 -m pip --no-cache-dir install stakkr'
sudo python3 -m pip --no-cache-dir install stakkr
