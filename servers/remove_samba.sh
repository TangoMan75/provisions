#!/bin/bash

#/**
# * samba
# * samba file sharing service
# *
# * @category servers
# * @link     https://askubuntu.com/questions/888205/how-to-set-up-an-entire-hard-drive-as-a-shared-drive-in-samba
# * @note     config here: /etc/samba/smb.conf
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get remove --assume-yes samba'
sudo apt-get remove --assume-yes samba

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

