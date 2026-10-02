#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## template
##
## A short description
##
## ```
## # example usage
## template -f foobar
## ```
##
## @category template
## @link     https://github.com/TangoMan75/template
## @link     https://flathub.org/apps/TangoMan75.template

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=template

#--------------------------------------------------

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

_echo_warning 'Create shortcut on desktop for flatpak app\n'

_echo_info "cp -p \"/var/lib/flatpak/app/${APP_NAME}/current/active/export/share/applications/${APP_NAME}.desktop\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/var/lib/flatpak/app/${APP_NAME}/current/active/export/share/applications/${APP_NAME}.desktop" "$(xdg-user-dir DESKTOP)"

