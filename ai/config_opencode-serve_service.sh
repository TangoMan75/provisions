#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## config opencode-serve service
##
## Installs and enables the systemd user unit that runs `opencode serve --service`.
##
## @category ai
## @link     https://opencode.ai

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

SYSTEMD_USER_DIR="${HOME}/.config/systemd/user"
OPENCODE_SERVE_UNIT="${SYSTEMD_USER_DIR}/opencode-serve.service"

#--------------------------------------------------

if [ "${EUID}" -eq 0 ]; then
    _echo_danger "error: run \"$(basename "${0}")\" as your user account, not as root\n"
    exit 1
fi

#--------------------------------------------------

REQUIRED_COMMANDS=(systemctl)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}\n"
        exit 1
    fi
done

#--------------------------------------------------

# OpenCode installs to ~/.opencode/bin, which is absent from PATH when the
# script is launched from a GUI, cron, or a minimal non-login shell.
OPENCODE_BIN=$(command -v opencode 2>/dev/null)
if [ -z "${OPENCODE_BIN}" ]; then
    for candidate in "${HOME}/.opencode/bin/opencode" '/usr/local/bin/opencode' '/usr/bin/opencode'; do
        if [ -x "${candidate}" ]; then
            OPENCODE_BIN="${candidate}"
            break
        fi
    done
fi

if [ -z "${OPENCODE_BIN}" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires opencode, run ai/install_opencode.sh first\n"
    exit 1
fi

#--------------------------------------------------

OPENCODE_VERSION=$("${OPENCODE_BIN}" --version 2>/dev/null | awk '{print $NF}')
if [[ ! "${OPENCODE_VERSION}" =~ ^v?2\. ]]; then
    _echo_danger "error: \"$(basename "${0}")\" requires OpenCode v2 (found ${OPENCODE_VERSION:-unknown})\n"
    exit 1
fi

#--------------------------------------------------

_alert_secondary "Config opencode service ${OPENCODE_VERSION}"

#--------------------------------------------------

_echo_info 'systemctl --user stop opencode-serve.service 2>/dev/null || true\n'
systemctl --user stop opencode-serve.service 2>/dev/null || true

#--------------------------------------------------

_echo_info "mkdir -p ${SYSTEMD_USER_DIR}\n"
mkdir -p "${SYSTEMD_USER_DIR}"

#--------------------------------------------------

# OpenCode v2 uses one shared background service per user. Service mode keeps the
# password in ~/.config/opencode/service.json and listens on port 49374 by default.

cat > "${OPENCODE_SERVE_UNIT}" <<- EOF
[Unit]
Description=opencode Serve
After=network-online.target
Wants=network-online.target
StartLimitIntervalSec=0

[Service]
Type=simple
ExecStart=${OPENCODE_BIN} serve --service
Restart=on-failure
RestartSec=5
KillMode=mixed
KillSignal=SIGTERM
TimeoutStopSec=30
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=default.target
EOF

_echo_info 'opencode-serve.service created\n'

#--------------------------------------------------

_echo_info 'systemctl --user daemon-reload\n'
systemctl --user daemon-reload

#--------------------------------------------------

# If a background service was already started outside systemd, the new unit exits
# cleanly and lets that service keep running until the next boot.

_echo_info 'systemctl --user enable --now opencode-serve.service\n'
systemctl --user enable --now opencode-serve.service

#--------------------------------------------------

if ! systemctl --user is-active --quiet opencode-serve.service; then
    _echo_warning 'an OpenCode service outside systemd is serving the API; the systemd unit will take over at the next boot\n'
fi
