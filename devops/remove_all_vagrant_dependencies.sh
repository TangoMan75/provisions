#!/bin/bash

#/**
# * remove all vagrant dependencies
# *
# * @category devops
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

if [ -n "$(vagrant status|grep 'running')" ]; then
    {
        echo_warning 'Vagrant running, attempting to stop'
        echo_info 'vagrant halt'
        vagrant halt
    } || {
        echo_error 'Stopping Vagrant failed'
    }
fi

if [ -z "$(vagrant status|grep 'running')" ]; then
    # uninstall virtualbox
    echo_caption 'uninstall virtualbox'
    echo_info 'sudo apt-get remove --assume-yes virtualbox-5.2'
    sudo apt-get remove --assume-yes virtualbox-5.2

    echo_info 'sudo groupdel vboxusers'
    sudo groupdel vboxusers
fi

# uninstall vagrant
echo_caption 'uninstall vagrant'
echo_info 'sudo rm -rf /opt/vagrant'
sudo rm -rf /opt/vagrant

echo_info 'sudo rm -f /usr/bin/vagrant'
sudo rm -f /usr/bin/vagrant

echo_info 'sudo rm -rf ~/.vagrant.d'
sudo rm -rf ~/.vagrant.d

echo_info 'sudo apt-get remove --assume-yes --autoremove vagrant'
sudo apt-get remove --assume-yes --autoremove vagrant

echo_info 'sudo dpkg -r vagrant'
sudo dpkg -r vagrant

# uninstall ruby
echo_caption 'uninstall ruby'
echo_info 'rvm remove ruby'
rvm remove ruby

echo_info 'sudo apt-get autoremove -y --autoremove ruby'
sudo apt-get autoremove -y --autoremove ruby

# uninstall rvm
echo_caption 'uninstall rvm'
# This will remove the rvm/ directory and all the rubies built within it.
echo_info 'rvm implode'
rvm implode

# In order to remove the final trace of rvm, you need to remove the rvm gem, too:
echo_info 'gem uninstall rvm'
gem uninstall rvm

# uninstall python
echo_caption 'uninstall python'
echo_info 'sudo apt-get remove --assume-yes --autoremove python-pip python-dev'
sudo apt-get remove --assume-yes --autoremove python-pip python-dev

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

# stopping nfs-kernel-server
echo_info 'sudo service nfs-kernel-server stop'
sudo service nfs-kernel-server stop

# uninstall essentials
echo_caption 'uninstall essentials'
echo_info 'sudo apt-get remove --assume-yes --autoremove autoconf'
sudo apt-get remove --assume-yes --autoremove autoconf

echo_info 'sudo apt-get remove --assume-yes --autoremove build-essential'
sudo apt-get remove --assume-yes --autoremove build-essential

echo_info 'sudo apt-get remove --assume-yes --autoremove libssl-dev'
sudo apt-get remove --assume-yes --autoremove libssl-dev

echo_info 'sudo apt-get remove --assume-yes --autoremove libxml2-dev'
sudo apt-get remove --assume-yes --autoremove libxml2-dev

echo_info 'sudo apt-get remove --assume-yes --autoremove libxslt-dev'
sudo apt-get remove --assume-yes --autoremove libxslt-dev

echo_info 'sudo apt-get remove --assume-yes --autoremove ruby-dev'
sudo apt-get remove --assume-yes --autoremove ruby-dev

# uninstall nfs server
echo_caption 'uninstall nfs'
echo_info 'sudo dpkg --purge nfs-kernel-server'
sudo dpkg --purge nfs-kernel-server

echo_info 'sudo dpkg --purge nfs-common'
sudo dpkg --purge nfs-common

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

