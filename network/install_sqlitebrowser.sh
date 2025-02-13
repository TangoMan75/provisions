#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## sqlitebrowser
## sqlite client database manager
##
## @category network
## @link     https://sqlitebrowser.org

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install sqlitebrowser'

echo_info 'sudo apt-get install --assume-yes sqlitebrowser\n'
sudo apt-get install --assume-yes sqlitebrowser

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/sqlitebrowser.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/sqlitebrowser.desktop "$(xdg-user-dir DESKTOP)"
