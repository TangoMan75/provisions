#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install_zeroclaw
##
## Install ZeroClaw - Fast, small, autonomous AI assistant infrastructure
##
## ```
## # config can be found here
## ~/.zeroclaw
##
## # biniary can be found here
## ~/.cargo/bin/zeroclaw
##
## # start onboarding
## zeroclaw onboard --interactive
## ```
##
## @category ai
## @link     https://github.com/zeroclaw-labs/zeroclaw
## @link     https://zeroclawlabs.ai

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(curl tar unzip wget)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

APP_NAME=zeroclaw
AUTHOR=zeroclaw-labs
REPOSITORY=${AUTHOR}/${APP_NAME}
BINARY="${APP_NAME}"
DESTINATION="${HOME}/.local/bin"

#--------------------------------------------------

VERSION=0.1.7

#--------------------------------------------------

# https://github.com/zeroclaw-labs/zeroclaw/releases/download/v0.1.7/zeroclaw-x86_64-unknown-linux-gnu.tar.gz
ARCH=$(uname -m | sed 's/x86_64/x86_64-unknown-linux-gnu/; s/aarch64/aarch64-unknown-linux-gnu/; s/armv7/armv7-unknown-linux-gnueabihf/')
REMOTE_FILE="${APP_NAME}-${ARCH}.tar.gz"
ARCHIVE="${REMOTE_FILE}"
URL="https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${REMOTE_FILE}"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME} v${VERSION}"

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

_echo_warning 'Downloading file to temporary directory\n'

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -sSLf \"${URL}\" -o \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
    curl -sSLf "${URL}" -o "${TEMP_DIR}/${REMOTE_FILE}"

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -q \"${URL}\" -O \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
    wget -q "${URL}" -O "${TEMP_DIR}/${REMOTE_FILE}"

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

#--------------------------------------------------

if [ ! -s "${TEMP_DIR}/${ARCHIVE}" ] || head -n 1 "${TEMP_DIR}/${ARCHIVE}" | grep -q "<!DOCTYPE html>"; then
    _echo_danger "error: Downloaded file is invalid or not found. Please check the architecture and URL.\n"
    _echo_info "Supported architectures: x86_64-unknown-linux-gnu, aarch64-unknown-linux-gnu, armv7-unknown-linux-gnueabihf\n"
    _echo_info "Your architecture: $(uname -m)\n"
    exit 1
fi

#--------------------------------------------------

_echo_warning "Extract \"${ARCHIVE}\"\n"

_echo_info "tar -xvzf \"${TEMP_DIR}/${ARCHIVE}\" -C \"${TEMP_DIR}\"\n"
tar -xvzf "${TEMP_DIR}/${ARCHIVE}" -C "${TEMP_DIR}"

#--------------------------------------------------

if [ ! -d "${DESTINATION}" ]; then
    _echo_warning 'Create destination folder\n'

    _echo_info "mkdir -p \"${DESTINATION}\"\n"
    mkdir -p "${DESTINATION}"
fi

#--------------------------------------------------

_echo_warning "Move binary to \"${DESTINATION}\"\n"

_echo_info "mv \"${TEMP_DIR}/${BINARY}\" \"${DESTINATION}\"\n"
mv "${TEMP_DIR}/${BINARY}" "${DESTINATION}"

#--------------------------------------------------

_echo_warning "Setting executable permissions for ${BINARY}\n"

_echo_info "chmod uga+x \"${DESTINATION}/${BINARY}\"\n"
chmod uga+x "${DESTINATION}/${BINARY}"

#--------------------------------------------------

_echo_warning 'Cleaning up temporary files\n'

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

if ! echo "${PATH}" | grep -q "${DESTINATION}"; then
    _echo_warning "${DESTINATION} is not in your PATH\n"
    _echo_info "To use ${APP_NAME} from anywhere, add the following to your shell profile:\n\n"
    _echo_warning "  export PATH=\"\$PATH:${DESTINATION}\"\n\n"
    _echo_info 'For bash, add it to ~/.bashrc or ~/.bash_profile\n'
    _echo_info 'For zsh, add it to ~/.zshrc\n'
    _echo_info "For fish, run: fish_add_path ${DESTINATION}\n"
fi
