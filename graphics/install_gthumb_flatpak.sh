#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install_gthumb_flatpak
##
## Install gThumb image viewer via Flatpak
##
## @category graphics
## @link     https://flathub.org/en/apps/org.gnome.gThumb

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=org.gnome.gThumb
DESKTOP="${APP_NAME}.desktop"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if ! command -v flatpak &> /dev/null; then
    _echo_danger "error: \"$(basename "${0}")\" requires flatpak, try: 'sudo apt-get install -y flatpak'\n"
    exit 1
fi

#--------------------------------------------------

_echo_info "flatpak install flathub -y \"${APP_NAME}\"\n"
flatpak install flathub -y "${APP_NAME}"

#--------------------------------------------------

_echo_warning 'Create shortcut on desktop for flatpak app\n'

_echo_info "cp -p \"/var/lib/flatpak/app/${APP_NAME}/current/active/export/share/applications/${DESKTOP}\" \"\$(xdg-user-dir DESKTOP)\"\n"
cp -p "/var/lib/flatpak/app/${APP_NAME}/current/active/export/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

