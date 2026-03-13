#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Gromit-MPX
##
## note: Toggle painting <F9>
##       Clear screen    <SHIFT><F9>
##
## @category graphics
## @link     https://flathub.org/apps/net.christianbeier.Gromit-MPX
## @link     https://github.com/bk138/gromit-mpx

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=net.christianbeier.Gromit-MPX

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v flatpak)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires flatpak\n"
    exit 1
fi

#--------------------------------------------------

_echo_info "flatpak install flathub -y \"${APP_NAME}\"\n"
flatpak install flathub -y "${APP_NAME}"

#--------------------------------------------------

# create shortcut on desktop for flatpak app
_echo_info "cp -p \"/var/lib/flatpak/app/${APP_NAME}/current/active/export/share/applications/${APP_NAME}.desktop\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/var/lib/flatpak/app/${APP_NAME}/current/active/export/share/applications/${APP_NAME}.desktop" "$(xdg-user-dir DESKTOP)"

