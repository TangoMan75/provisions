#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## openconnect
##
## VPN client
##
## ```
## sudo openconnect --protocol=nc https://vpn.domainname.io -u username
## ```
##
## @category security

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install openconnect'

echo_info 'sudo apt-get install --assume-yes network-manager-openconnect-gnome\n'
sudo apt-get install --assume-yes network-manager-openconnect-gnome

