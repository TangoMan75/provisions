#!/bin/bash

#/**
# * remove nfs file sharing server
# *
# * @category servers
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

# stopping nfs-kernel-server
echo_info 'sudo service nfs-kernel-server stop'
sudo service nfs-kernel-server stop

# uninstall nfs server
echo_caption 'uninstall nfs'
echo_info 'sudo dpkg --purge nfs-kernel-server'
sudo dpkg --purge nfs-kernel-server

echo_info 'sudo dpkg --purge nfs-common'
sudo dpkg --purge nfs-common

