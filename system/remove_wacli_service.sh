#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io">
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove wacli_service
##
## Stops and removes the wacli systemd user service. The wacli
## binary, the local message store and the WhatsApp device link
## are left untouched (use cli/remove_wacli.sh to fully uninstall).
##
## @category system
## @link     https://github.com/openclaw/wacli

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=wacli
SERVICE_NAME="${APP_NAME}.service"
DEST_DIR="${HOME}/.config/systemd/user"
DEST_FILE="${DEST_DIR}/${SERVICE_NAME}"

#--------------------------------------------------

_alert_danger "Remove ${SERVICE_NAME}"

#--------------------------------------------------

if [ ! -f "${DEST_FILE}" ]; then
    _echo_warning "Service file not found at ${DEST_FILE}, nothing to do\n"
    exit 0
fi

#--------------------------------------------------

_echo_warning "Stop and disable the service\n"

_echo_info "systemctl --user disable --now \"${SERVICE_NAME}\"\n"
systemctl --user disable --now "${SERVICE_NAME}" || true

#--------------------------------------------------

_echo_warning "Remove service file\n"

_echo_info "rm -f \"${DEST_FILE}\"\n"
rm -f "${DEST_FILE}"

#--------------------------------------------------

_echo_warning "Reload systemd user manager\n"

_echo_info "systemctl --user daemon-reload\n"
systemctl --user daemon-reload

_echo_info "systemctl --user reset-failed \"${SERVICE_NAME}\"\n"
systemctl --user reset-failed "${SERVICE_NAME}" || true

#--------------------------------------------------

_echo_warning 'Unpair the WhatsApp device manually\n'
_echo_info 'Open WhatsApp on your phone, then: Settings > Linked Devices > select this device > Log out.\n'
