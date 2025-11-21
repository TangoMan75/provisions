#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## BreakTimer
##
## @category productivity
## @link     https://flathub.org/apps/org.gnome.BreakTimer
## @link     https://wiki.gnome.org/Apps(2f)BreakTimer.html

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=org.gnome.BreakTimer

alert_primary "Install ${APP_NAME}"

if [ ! -x "$(command -v flatpak)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires flatpak\n"
    exit 1
fi

echo_info "flatpak install flathub -y \"${APP_NAME}\"\n"
flatpak install flathub -y "${APP_NAME}"

#--------------------------------------------------

# create shortcut on desktop for flatpak app
echo_info "cp -p \"/var/lib/flatpak/app/${APP_NAME}/current/active/export/share/applications/${APP_NAME}.desktop\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/var/lib/flatpak/app/${APP_NAME}/current/active/export/share/applications/${APP_NAME}.desktop" "$(xdg-user-dir DESKTOP)"

