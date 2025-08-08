#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## lutris
##
## @category games
## @link     https://lutris.net

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# --------------------------------------------------

alert_primary 'Install Lutris'

echo_info 'sudo add-apt-repository --yes ppa:lutris-team/lutris\n'
sudo add-apt-repository --yes ppa:lutris-team/lutris

echo_info 'sudo apt-get install --assume-yes lutris\n'
sudo apt-get install --assume-yes lutris

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/net.lutris.Lutris.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/net.lutris.Lutris.desktop "$(xdg-user-dir DESKTOP)"
