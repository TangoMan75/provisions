#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * remove chef
# *
# * @category devops
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_danger 'Remove chefdk'

echo_info 'sudo apt-get purge --assume-yes chef'
sudo apt-get purge --assume-yes chef

# uninstall chefdk
echo_warning 'uninstall chefdk'

echo_info 'sudo dpkg --purge chefdk'
sudo dpkg --purge chefdk

# uninstall chef-solo
echo_warning 'uninstall chef-solo'

echo_info 'sudo dpkg --purge chef-solo'
sudo dpkg --purge chef

# berks and chef doesn't uninstall properly
echo_info 'rm -rf /opt/chef'
rm -rf /opt/chef

echo_info 'rm -rf ~/.berkshelf'
rm -rf ~/.berkshelf

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

