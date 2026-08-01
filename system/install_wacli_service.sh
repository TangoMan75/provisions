#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io">
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install_wacli_service
##
## Installs a systemd user service that runs `wacli sync --follow`
## in the background. The service auto-restarts on network blips
## and starts on user login via lingering.
##
## Requires:
##   - wacli installed at ~/.local/bin/wacli (cli/install_wacli.sh)
##   - WhatsApp account paired once via `wacli auth`
##
## ```
## # Trigger an initial QR pairing (one time, interactive)
## wacli auth
##
## # Inspect service state
## systemctl --user status wacli
## journalctl --user -u wacli -f
## ```
##
## @category system
## @link     https://github.com/openclaw/wacli
## @link     https://wacli.sh

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=wacli
SERVICE_NAME="${APP_NAME}.service"
SOURCE_FILE="${CURDIR}/${SERVICE_NAME}"
DEST_DIR="${HOME}/.config/systemd/user"
DEST_FILE="${DEST_DIR}/${SERVICE_NAME}"
BINARY="${HOME}/.local/bin/${APP_NAME}"

#--------------------------------------------------

# Check for required commands
if ! command -v systemctl &> /dev/null; then
    _echo_danger "error: \"$(basename "${0}")\" requires systemd, try: 'sudo apt-get install -y systemd'\n"
    exit 1
fi

if [ ! -x "${BINARY}" ]; then
    _echo_danger "error: wacli not found at ${BINARY}, run cli/install_wacli.sh first\n"
    exit 1
fi

if [ ! -f "${SOURCE_FILE}" ]; then
    _echo_danger "error: service template not found at ${SOURCE_FILE}\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary "Install ${SERVICE_NAME} (systemd user unit)"

#--------------------------------------------------

_echo_warning "Ensure systemd user directory exists\n"

_echo_info "mkdir -p \"${DEST_DIR}\"\n"
mkdir -p "${DEST_DIR}"

#--------------------------------------------------

_echo_warning "Install service file\n"

_echo_info "cp \"${SOURCE_FILE}\" \"${DEST_FILE}\"\n"
cp "${SOURCE_FILE}" "${DEST_FILE}"

_echo_info "chmod 644 \"${DEST_FILE}\"\n"
chmod 644 "${DEST_FILE}"

#--------------------------------------------------

_echo_warning "Reload systemd user manager\n"

_echo_info "systemctl --user daemon-reload\n"
systemctl --user daemon-reload

#--------------------------------------------------

_echo_warning "Enable lingering so the user service runs even when logged out\n"

_echo_info "loginctl enable-linger \"${USER}\"\n"
loginctl enable-linger "${USER}"

#--------------------------------------------------

_echo_warning "Enable and start ${SERVICE_NAME}\n"

_echo_info "systemctl --user enable --now \"${SERVICE_NAME}\"\n"
systemctl --user enable --now "${SERVICE_NAME}"

#--------------------------------------------------

_echo_warning "Verify service status\n"

_echo_info "systemctl --user --no-pager status \"${SERVICE_NAME}\"\n"
systemctl --user --no-pager status "${SERVICE_NAME}" || true

#--------------------------------------------------

_echo_warning "Next steps\n"
_echo_info "If the service is \"active (waiting)\" or fails to authenticate, run \"wacli auth\" once interactively to scan the QR code.\n"
_echo_info "Tail logs with: journalctl --user -u ${SERVICE_NAME} -f\n"
