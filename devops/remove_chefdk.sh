#!/bin/bash

#/**
# * remove chef
# *
# * @category devops
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get purge --assume-yes chef'
sudo apt-get purge --assume-yes chef

# uninstall chefdk
echo_caption 'uninstall chefdk'
echo_info 'sudo dpkg -P chefdk'
sudo dpkg --purge chefdk

# uninstall chef-solo
echo_caption 'uninstall chef-solo'
echo_info 'sudo dpkg -P chef-solo'
sudo dpkg --purge chef

# berks and chef doesn't uninstall properly
echo_info 'rm -rf /opt/chef'
rm -rf /opt/chef

echo_info 'rm -rf ~/.berkshelf'
rm -rf ~/.berkshelf

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

