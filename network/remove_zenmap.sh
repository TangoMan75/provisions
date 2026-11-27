#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## zenmap
## nmap network scanner graphic interface
##
## @category network

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=zenmap
DESKTOP="zenmap.desktop"
ICON="zenmap.png"

ROOT_DESKTOP="zenmap-root.desktop"
ROOT_LAUNCHER="zenmap-root"

#--------------------------------------------------

_alert_danger 'Remove zenmap'

#--------------------------------------------------

if command -v pipx &> /dev/null; then
    _echo_info "pipx uninstall \"${APP_NAME}\"\n"
    pipx uninstall "${APP_NAME}" || _echo_warning "${APP_NAME} is not installed with pipx\n"
fi

#--------------------------------------------------

_echo_warning 'Remove system-wide symlink\n'

_echo_info "sudo rm -f \"/usr/bin/${APP_NAME}\"\n"
sudo rm -f "/usr/bin/${APP_NAME}"

_echo_info "sudo rm -f \"/usr/local/bin/${ROOT_LAUNCHER}\"\n"
sudo rm -f "/usr/local/bin/${ROOT_LAUNCHER}"

#--------------------------------------------------

_echo_warning 'Remove desktop entry and icon\n'

_echo_info "sudo rm -f \"/usr/share/applications/${DESKTOP}\"\n"
sudo rm -f "/usr/share/applications/${DESKTOP}"

_echo_info "sudo rm -f \"/usr/share/applications/${ROOT_DESKTOP}\"\n"
sudo rm -f "/usr/share/applications/${ROOT_DESKTOP}"

_echo_info "sudo rm -f \"/usr/share/icons/hicolor/256x256/apps/${ICON}\"\n"
sudo rm -f "/usr/share/icons/hicolor/256x256/apps/${ICON}"

sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor &> /dev/null || true
sudo update-desktop-database /usr/share/applications &> /dev/null || true

#--------------------------------------------------

if command -v xdg-user-dir &> /dev/null; then
    DESKTOP_DIR=$(xdg-user-dir DESKTOP)
    for shortcut in "${DESKTOP}" "${ROOT_DESKTOP}"; do
        if [ -f "${DESKTOP_DIR}/${shortcut}" ]; then
            _echo_info "rm -f \"${DESKTOP_DIR}/${shortcut}\"\n"
            rm -f "${DESKTOP_DIR}/${shortcut}"
        fi
    done
fi
