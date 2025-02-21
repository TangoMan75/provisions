#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## secrets
##
## Manage KeePass databases
##
## @category security

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install secrets'

echo_info 'sudo apt-get install --assume-yes secrets\n'
sudo apt-get install --assume-yes secrets

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/org.gnome.World.Secrets.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/org.gnome.World.Secrets.desktop "$(xdg-user-dir DESKTOP)"
