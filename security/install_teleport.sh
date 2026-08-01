#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install teleport
##
## SSH and Kubernetes access plane
##
## ```bash
## teleport version
## ```
##
## @category security
## @link     https://goteleport.com
## @link     https://goteleport.com/docs/installation/single-machine/linux

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=teleport
DEFAULT_VERSION=v18

#--------------------------------------------------

KEYRING_URL=https://apt.releases.teleport.dev/gpg
KEYRING="${APP_NAME}.gpg"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v curl)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'\n"
    exit 1
fi

if [ ! -x "$(command -v gpg)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires gnupg, try: 'sudo apt-get install -y gnupg'\n"
    exit 1
fi

#--------------------------------------------------

# shellcheck source=/dev/null
. /etc/os-release

TELEPORT_VERSION="${TELEPORT_VERSION:-${DEFAULT_VERSION}}"
TELEPORT_CHANNEL="stable/${TELEPORT_VERSION}"

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

_echo_warning 'Install gpg key\n'

_echo_info "curl -fsSL \"${KEYRING_URL}\" | gpg --dearmor > \"${TEMP_DIR}/${KEYRING}\"\n"
curl -fsSL "${KEYRING_URL}" | gpg --dearmor > "${TEMP_DIR}/${KEYRING}"

_echo_info "sudo install -D -o root -g root -m 644 \"${TEMP_DIR}/${KEYRING}\" /etc/apt/keyrings/${KEYRING}\n"
sudo install -D -o root -g root -m 644 "${TEMP_DIR}/${KEYRING}" /etc/apt/keyrings/${KEYRING}

_echo_info "echo \"deb [arch=amd64 signed-by=/etc/apt/keyrings/${KEYRING}] https://apt.releases.teleport.dev/${ID} ${VERSION_CODENAME} ${TELEPORT_CHANNEL}\" | sudo tee /etc/apt/sources.list.d/${APP_NAME}.list > /dev/null\n"
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/${KEYRING}] https://apt.releases.teleport.dev/${ID} ${VERSION_CODENAME} ${TELEPORT_CHANNEL}" | sudo tee /etc/apt/sources.list.d/${APP_NAME}.list > /dev/null

#--------------------------------------------------

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"

