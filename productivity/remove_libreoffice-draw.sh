#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove joplin
##
## @category productivity

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=libreoffice-draw

alert_primary "Remove ${APP_NAME}"

echo_info "sudo apt-get purge --assume-yes \"${APP_NAME}\"\n"
sudo apt-get purge --assume-yes "${APP_NAME}"

echo_info "sudo apt-get --assume-yes autoremove\n"
sudo apt-get --assume-yes autoremove

#--------------------------------------------------

# remove shortcut on desktop for flatpak app
echo_info "rm \"$(xdg-user-dir DESKTOP)/${APP_NAME}.desktop\"\n"
rm "$(xdg-user-dir DESKTOP)/${APP_NAME}.desktop"

