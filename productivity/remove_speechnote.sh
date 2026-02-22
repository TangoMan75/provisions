#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Speech Note
##
## Notes with offline Speech to Text, Text to Speech and Machine Translation
##
## @category productivity
## @link     https://flathub.org/apps/net.mkiol.SpeechNote

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=net.mkiol.SpeechNote

#--------------------------------------------------

if [ ! -x "$(command -v flatpak)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires flatpak\n"
    exit 1
fi

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info "flatpak uninstall -y --delete-data \"${APP_NAME}\"\n"
flatpak uninstall -y --delete-data "${APP_NAME}"

#--------------------------------------------------

# remove shortcut on desktop for flatpak app
_echo_info "rm \"$(xdg-user-dir DESKTOP)/${APP_NAME}.desktop\"\n"
rm "$(xdg-user-dir DESKTOP)/${APP_NAME}.desktop"

