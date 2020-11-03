#!/bin/bash

#/**
# * filezilla
# * ftp client
# *
# * @category network
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes filezilla'
sudo apt-get install --assume-yes filezilla
