#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
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

#--------------------------------------------------

DESKTOP=thunar.desktop

_alert_primary 'Install Thunar'

_echo_info 'sudo apt-get install --assume-yes --no-install-recommends thunar\n'
sudo apt-get install --assume-yes --no-install-recommends thunar

_echo_info 'sudo apt-get install --assume-yes thunar-media-tags-plugin\n'
sudo apt-get install --assume-yes thunar-media-tags-plugin

#--------------------------------------------------

# create shortcut on desktop
_echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

