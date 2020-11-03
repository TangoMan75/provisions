#!/bin/bash

#/**
# * samba
# *
# * samba file sharing service (default service on ubuntu not NFS as one could expect)
# *
# * @category servers
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes samba'
sudo apt-get install --assume-yes samba
