#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## config opencode Telegram bot service
##
## Installs and enables the systemd user unit that runs `opencode-telegram`, and
## points the bot to the local OpenCode service.
##
## @category ai
## @link     https://github.com/grinev/opencode-telegram-bot

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/env/set_variable.sh"

#--------------------------------------------------

SYSTEMD_USER_DIR="${HOME}/.config/systemd/user"
OPENCODE_TELEGRAM_ENV="${HOME}/.config/opencode-telegram-bot/.env"
OPENCODE_TELEGRAM_UNIT="${SYSTEMD_USER_DIR}/opencode-telegram.service"

#--------------------------------------------------

if [ "${EUID}" -eq 0 ]; then
    _echo_danger "error: run \"$(basename "${0}")\" as your user account, not as root\n"
    exit 1
fi

#--------------------------------------------------

REQUIRED_COMMANDS=(curl systemctl)
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

TELEGRAM_BIN=$(command -v opencode-telegram 2>/dev/null)
if [ -z "${TELEGRAM_BIN}" ]; then
    for candidate in '/usr/local/bin/opencode-telegram' '/usr/bin/opencode-telegram'; do
        if [ -x "${candidate}" ]; then
            TELEGRAM_BIN="${candidate}"
            break
        fi
    done
fi

OPENCODE_API_URL=$("${OPENCODE_BIN}" service status 2>/dev/null | head -n 1)
OPENCODE_PORT=$(printf '%s\n' "${OPENCODE_API_URL}" | sed -nE 's#^.*:([0-9]+)/?.*$#\1#p')
if [[ ! "${OPENCODE_PORT}" =~ ^[0-9]+$ ]]; then
    OPENCODE_PORT=49374
    OPENCODE_API_URL="http://127.0.0.1:${OPENCODE_PORT}"
fi

#--------------------------------------------------

_alert_secondary 'Config opencode Telegram bot service'

#--------------------------------------------------

if [ -z "${TELEGRAM_BIN}" ]; then
    _echo_warning 'warning: opencode-telegram is not installed, skipping bot service\n'
    exit 0
fi

if [ ! -f "${OPENCODE_TELEGRAM_ENV}" ]; then
    _echo_warning "warning: ${OPENCODE_TELEGRAM_ENV} not found\n"
    _echo_warning "run 'opencode-telegram config' to create it, then re-run this script\n"
    exit 0
fi

#--------------------------------------------------

_echo_info 'systemctl --user stop opencode-telegram.service 2>/dev/null || true\n'
systemctl --user stop opencode-telegram.service 2>/dev/null || true

#--------------------------------------------------

_echo_info "mkdir -p ${SYSTEMD_USER_DIR}\n"
mkdir -p "${SYSTEMD_USER_DIR}"

#--------------------------------------------------

cat > "${OPENCODE_TELEGRAM_UNIT}" <<- EOF
[Unit]
Description=opencode Telegram Bot
After=network-online.target opencode-serve.service
Wants=network-online.target
StartLimitIntervalSec=0

[Service]
Type=simple
ExecStartPre=/bin/sh -c 'for i in \$(seq 1 30); do curl -so /dev/null http://127.0.0.1:${OPENCODE_PORT}/ 2>/dev/null && exit 0; sleep 2; done; exit 1'
ExecStartPre=/bin/sh -c 'for i in \$(seq 1 30); do curl -so /dev/null https://api.telegram.org/ 2>/dev/null && exit 0; sleep 2; done; exit 1'
ExecStart=${TELEGRAM_BIN}
Restart=always
RestartSec=15
KillMode=mixed
KillSignal=SIGTERM
TimeoutStopSec=30
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=default.target
EOF

_echo_info 'opencode-telegram.service created\n'

#--------------------------------------------------

_echo_info 'systemctl --user daemon-reload\n'
systemctl --user daemon-reload

#--------------------------------------------------

_echo_info "opencode service status: ${OPENCODE_API_URL}\n"
OPENCODE_SERVER_PASSWORD=''
for _ in $(seq 1 30); do
    OPENCODE_SERVER_PASSWORD=$("${OPENCODE_BIN}" service get password 2>/dev/null | head -n 1)
    if [ -n "${OPENCODE_SERVER_PASSWORD}" ]; then
        break
    fi
    sleep 2
done

if [ -z "${OPENCODE_SERVER_PASSWORD}" ]; then
    _echo_danger 'error: could not read the OpenCode service password, run ai/config_opencode-serve_service.sh first\n'
    exit 1
fi

#--------------------------------------------------

_echo_info "configure ${OPENCODE_TELEGRAM_ENV}\n"

_echo_warning 'Force opencode-telegram-bot to use ipv4 and OpenCode v2\n'

set_env_variable 'TELEGRAM_FORCE_IPV4' 'true' "${OPENCODE_TELEGRAM_ENV}"
set_env_variable 'OPENCODE_SERVER_VERSION' 'v2' "${OPENCODE_TELEGRAM_ENV}"
set_env_variable 'OPENCODE_API_URL' "${OPENCODE_API_URL}" "${OPENCODE_TELEGRAM_ENV}"
set_env_variable 'OPENCODE_SERVER_USERNAME' 'opencode' "${OPENCODE_TELEGRAM_ENV}"
set_env_variable 'OPENCODE_SERVER_PASSWORD' "${OPENCODE_SERVER_PASSWORD}" "${OPENCODE_TELEGRAM_ENV}"

_echo_info "chmod 600 ${OPENCODE_TELEGRAM_ENV}\n"
chmod 600 "${OPENCODE_TELEGRAM_ENV}"

#--------------------------------------------------

_echo_info 'systemctl --user enable opencode-telegram.service\n'
systemctl --user enable opencode-telegram.service

#--------------------------------------------------

_echo_info 'systemctl --user restart opencode-telegram.service\n'
systemctl --user restart opencode-telegram.service
