#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove chef
##
## @category devops

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

alert_danger 'Remove chefdk'

echo_info 'sudo apt-get purge --assume-yes chef\n'
sudo apt-get purge --assume-yes chef

# uninstall chefdk
echo_warning 'uninstall chefdk'

echo_info 'sudo dpkg --purge chefdk\n'
sudo dpkg --purge chefdk

# uninstall chef-solo
echo_warning 'uninstall chef-solo'

echo_info 'sudo dpkg --purge chef-solo\n'
sudo dpkg --purge chef

# berks and chef doesn't uninstall properly
echo_info 'rm -rf /opt/chef\n'
rm -rf /opt/chef

echo_info 'rm -rf ~/.berkshelf\n'
rm -rf ~/.berkshelf

echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove

