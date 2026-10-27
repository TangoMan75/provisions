#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove telegram-desktop
##
## @category communication
## @link     https://desktop.telegram.org
## @link     https://github.com/telegramdesktop/tdesktop

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=telegram-desktop
DESTINATION="${HOME}/.local/share/${APP_NAME}"
APPLICATIONS_DIR="${HOME}/.local/share/applications"
DESKTOP="${APP_NAME}.desktop"

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info "rm -f \"${HOME}/.local/bin/${APP_NAME}\"\n"
rm -f "${HOME}/.local/bin/${APP_NAME}"

#--------------------------------------------------

_echo_info "rm -rf \"${DESTINATION}\"\n"
rm -rf "${DESTINATION}"

#--------------------------------------------------

_echo_info "rm -f \"${APPLICATIONS_DIR}/${DESKTOP}\"\n"
rm -f "${APPLICATIONS_DIR}/${DESKTOP}"

if [ -x "$(command -v update-desktop-database)" ]; then
    _echo_info "update-desktop-database \"${APPLICATIONS_DIR}\"\n"
    update-desktop-database "${APPLICATIONS_DIR}"
fi

#--------------------------------------------------

# remove desktop shortcut
if [ -x "$(command -v xdg-user-dir)" ]; then
    _echo_info "rm -f \"$(xdg-user-dir DESKTOP)/${DESKTOP}\"\n"
    rm -f "$(xdg-user-dir DESKTOP)"/"${DESKTOP}"
fi

#--------------------------------------------------

_echo_warning "User data was kept in \"${HOME}/.local/share/TelegramDesktop\"\n"
_echo_info "Remove it manually if you want to delete your local Telegram session and cache.\n"
