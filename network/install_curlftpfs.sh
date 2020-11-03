#!/bin/bash

#/**
# * curlftpfs
# * mount remote ftp on local file system
# *
# * @category network
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes curlftpfs'
sudo apt-get install --assume-yes curlftpfs
