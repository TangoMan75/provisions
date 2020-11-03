#!/bin/bash

#/**
# * jmtpfs
# *
# * Allows to mount android file system over usb
# *
# * @category drivers
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes jmtpfs'
sudo apt-get install --assume-yes jmtpfs

