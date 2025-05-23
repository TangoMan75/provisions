#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## thunar
## bulk rename
##
## @category utils

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# --------------------------------------------------

DESKTOP=thunar.desktop

alert_primary 'Install Thunar'

echo_info 'sudo apt-get install --assume-yes --no-install-recommends thunar\n'
sudo apt-get install --assume-yes --no-install-recommends thunar

echo_info 'sudo apt-get install --assume-yes thunar-media-tags-plugin\n'
sudo apt-get install --assume-yes thunar-media-tags-plugin

# --------------------------------------------------

# create shortcut on desktop
echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

