#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove all vagrant dependencies
##
## @category devops

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# --------------------------------------------------

alert_danger 'Remove all vagrant dependencies'

if vagrant status 2>/dev/null | grep -q 'running'; then
    {
        echo_warning 'Vagrant running, attempting to stop'
        echo_info 'vagrant halt\n'
        vagrant halt
    } || {
        echo_danger 'error: Stopping Vagrant failed'
    }
fi

if vagrant status 2>/dev/null | grep  -q 'running'; then
    # uninstall virtualbox
    echo_warning 'uninstall virtualbox'

    echo_info 'sudo apt-get remove --assume-yes virtualbox-5.2\n'
    sudo apt-get remove --assume-yes virtualbox-5.2

    echo_info 'sudo groupdel vboxusers\n'
    sudo groupdel vboxusers
fi

# uninstall vagrant
echo_warning 'uninstall vagrant'

echo_info 'sudo rm -rf /opt/vagrant\n'
sudo rm -rf /opt/vagrant

echo_info 'sudo rm -f /usr/bin/vagrant\n'
sudo rm -f /usr/bin/vagrant

echo_info 'sudo rm -rf ~/.vagrant.d\n'
sudo rm -rf ~/.vagrant.d

echo_info 'sudo apt-get remove --assume-yes --autoremove vagrant\n'
sudo apt-get remove --assume-yes --autoremove vagrant

echo_info 'sudo dpkg --remove vagrant\n'
sudo dpkg --remove vagrant

# uninstall ruby
echo_warning 'uninstall ruby'

echo_info 'rvm remove ruby\n'
rvm remove ruby

echo_info 'sudo apt-get autoremove -y --autoremove ruby\n'
sudo apt-get autoremove -y --autoremove ruby

# uninstall rvm
echo_warning 'uninstall rvm'

# This will remove the rvm/ directory and all the rubies built within it.
echo_info 'rvm implode\n'
rvm implode

# In order to remove the final trace of rvm, you need to remove the rvm gem, too:
echo_info 'gem uninstall rvm\n'
gem uninstall rvm

# uninstall python
echo_warning 'uninstall python'

echo_info 'sudo apt-get remove --assume-yes --autoremove python-pip python-dev\n'
sudo apt-get remove --assume-yes --autoremove python-pip python-dev

# uninstall chefdk
echo_warning 'uninstall chefdk'

echo_info 'sudo dpkg -P chefdk\n'
sudo dpkg --purge chefdk

# uninstall chef-solo
echo_warning 'uninstall chef-solo'

echo_info 'sudo dpkg -P chef-solo\n'
sudo dpkg --purge chef

# berks and chef doesn't uninstall properly
echo_info 'rm -rf /opt/chef\n'
rm -rf /opt/chef

echo_info 'rm -rf ~/.berkshelf\n'
rm -rf ~/.berkshelf

# stopping nfs-kernel-server
echo_info 'sudo service nfs-kernel-server stop\n'
sudo service nfs-kernel-server stop

# uninstall essentials
echo_warning 'uninstall essentials'

echo_info 'sudo apt-get remove --assume-yes --autoremove autoconf\n'
sudo apt-get remove --assume-yes --autoremove autoconf

echo_info 'sudo apt-get remove --assume-yes --autoremove build-essential\n'
sudo apt-get remove --assume-yes --autoremove build-essential

echo_info 'sudo apt-get remove --assume-yes --autoremove libssl-dev\n'
sudo apt-get remove --assume-yes --autoremove libssl-dev

echo_info 'sudo apt-get remove --assume-yes --autoremove libxml2-dev\n'
sudo apt-get remove --assume-yes --autoremove libxml2-dev

echo_info 'sudo apt-get remove --assume-yes --autoremove libxslt-dev\n'
sudo apt-get remove --assume-yes --autoremove libxslt-dev

echo_info 'sudo apt-get remove --assume-yes --autoremove ruby-dev\n'
sudo apt-get remove --assume-yes --autoremove ruby-dev

# uninstall nfs server
echo_warning 'uninstall nfs'

echo_info 'sudo dpkg --purge nfs-kernel-server\n'
sudo dpkg --purge nfs-kernel-server

echo_info 'sudo dpkg --purge nfs-common\n'
sudo dpkg --purge nfs-common

echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove

