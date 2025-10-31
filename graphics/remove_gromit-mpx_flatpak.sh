#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Gromit-MPX
##
## @category graphics
## @link     https://flathub.org/apps/net.christianbeier.Gromit-MPX
## @link     https://github.com/bk138/gromit-mpx

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=net.christianbeier.Gromit-MPX

alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v flatpak)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires flatpak\n"
    exit 1
fi

#--------------------------------------------------

echo_info "flatpak uninstall -y --delete-data \"${APP_NAME}\"\n"
flatpak uninstall -y --delete-data "${APP_NAME}"

#--------------------------------------------------

# remove shortcut on desktop for flatpak app
echo_info "rm \"$(xdg-user-dir DESKTOP)/${APP_NAME}.desktop\"\n"
rm "$(xdg-user-dir DESKTOP)/${APP_NAME}.desktop"

