#!/bin/bash

#/**
# * mysql-workbench
# * mysql client database manager
# *
# * @category network
# * @link     https://dev.mysql.com/doc/workbench/en
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes mysql-workbench'
sudo apt-get install --assume-yes mysql-workbench
