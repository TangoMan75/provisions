#!/bin/bash

#/**
# * check malware
# *
# * @category kali
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo /usr/sbin/chkrootkit'
sudo /usr/sbin/chkrootkit

echo_info 'sudo rkhunter -c'
sudo rkhunter -c

# update Metasploit
echo_info 'sudo apt-get install --assume-yes metasploit-framework'
sudo apt-get install --assume-yes metasploit-framework
