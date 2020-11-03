#!/bin/bash

#/**
# * build-essentials
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get -y install autoconf'
sudo apt-get -y install autoconf

echo_info 'sudo apt-get -y install build-essential'
sudo apt-get -y install build-essential

echo_info 'sudo apt-get -y install libssl-dev'
sudo apt-get -y install libssl-dev

echo_info 'sudo apt-get -y install libxml2-dev'
sudo apt-get -y install libxml2-dev

echo_info 'sudo apt-get -y install libxslt-dev'
sudo apt-get -y install libxslt-dev

echo_info 'sudo apt-get -y install ruby-dev'
sudo apt-get -y install ruby-dev
