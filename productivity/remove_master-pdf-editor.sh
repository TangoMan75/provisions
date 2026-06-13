#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove master-pdf-editor
##
## @category productivity

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=master-pdf-editor-5
DESKTOP=net.code-industry.masterpdfeditor5.desktop

_alert_danger "Remove ${APP_NAME}"

_echo_info "sudo apt-get purge --assume-yes \"${APP_NAME}\"\n"
sudo apt-get purge --assume-yes "${APP_NAME}"

_echo_info "sudo apt-get --assume-yes autoremove\n"
sudo apt-get --assume-yes autoremove

#--------------------------------------------------

# remove shortcut on desktop for flatpak app
_echo_info "rm \"$(xdg-user-dir DESKTOP)/${DESKTOP}\"\n"
rm "$(xdg-user-dir DESKTOP)/${DESKTOP}"

