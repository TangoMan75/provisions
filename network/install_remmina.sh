#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remmina
## remote desktop client
##
## @category network

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install remmina'

_echo_info 'sudo apt-get install --assume-yes remmina\n'
sudo apt-get install --assume-yes remmina

# create shortcut on desktop
_echo_info "cp -p /usr/share/applications/org.remmina.Remmina.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/org.remmina.Remmina.desktop "$(xdg-user-dir DESKTOP)"
