#!/bin/bash

#/**
# * nfs-server
# * nfs file sharing server
# *
# * @category servers
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes nfs-common'
sudo apt-get install --assume-yes nfs-common

echo_info 'sudo apt-get install --assume-yes nfs-kernel-server'
sudo apt-get install --assume-yes nfs-kernel-server

echo_info 'sudo apt-get install --assume-yes nfs-server'
sudo apt-get install --assume-yes nfs-server

# starting nfs-kernel-server
echo_info 'sudo service nfs-kernel-server start'
sudo service nfs-kernel-server start

