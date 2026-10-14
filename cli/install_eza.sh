#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## eza
##
## A modern, Rust-based replacement for the ls command
##
## @category cli
## @link     https://eza.rocks
## @link     https://github.com/eza-community/eza

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(curl tar)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

APP_NAME="eza"
AUTHOR=eza-community
REPOSITORY="${AUTHOR}/${APP_NAME}"
BINARY="${APP_NAME}"
DESTINATION="/usr/bin"

#--------------------------------------------------

VERSION=$(get_latest_release "${REPOSITORY}")
if [ -z "${VERSION}" ]; then
    VERSION=0.23.5
fi

#--------------------------------------------------

# Map uname to eza's target triples
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
case "${OS}" in
    linux)
        case "$(uname -m)" in
            x86_64) TARGET=x86_64-unknown-linux-gnu ;;
            aarch64|arm64) TARGET=aarch64-unknown-linux-gnu ;;
            armv7l|armv6l) TARGET=arm-unknown-linux-gnueabihf ;;
            *) _echo_danger "error: Unsupported architecture \"$(uname -m)\".\n"; exit 1 ;;
        esac
        ;;
    *)
        _echo_danger "error: Unsupported operating system \"${OS}\".\n"
        exit 1
        ;;
esac

# eza release assets are named without the version (eza_<target>.tar.gz)
REMOTE_FILE="${APP_NAME}_${TARGET}.tar.gz"
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
    _echo_info "curl -Lf \"${URL}\" -o \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
    curl -Lf "${URL}" -o "${TEMP_DIR}/${REMOTE_FILE}"
elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -q \"${URL}\" -O \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
    wget -q "${URL}" -O "${TEMP_DIR}/${REMOTE_FILE}"
else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

# Check if the downloaded file is valid (not empty and not an HTML error page)
if [ ! -s "${TEMP_DIR}/${REMOTE_FILE}" ] || head -n 1 "${TEMP_DIR}/${REMOTE_FILE}" | grep -q "<!DOCTYPE html>"; then
    _echo_danger "error: Downloaded file is invalid or not found. Please check the architecture and URL.\n"
    _echo_info "Supported architectures: x86_64, aarch64\n"
    _echo_info "Your architecture: ${TARGET}\n"
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

_echo_info "sudo mv \"${TEMP_DIR}/${BINARY}\" \"${DESTINATION}\"\n"
sudo mv "${TEMP_DIR}/${BINARY}" "${DESTINATION}"

#--------------------------------------------------

_echo_warning "Setting executable permissions for ${BINARY}\n"

_echo_info "chmod uga+x \"${DESTINATION}/${BINARY}\"\n"
chmod uga+x "${DESTINATION}/${BINARY}"

#--------------------------------------------------

_echo_warning 'Cleaning up temporary files\n'

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

_echo_warning 'Alias eza to ls (optional)\n'
_echo_info 'Add the following lines to your ~/.bashrc or ~/.zshrc:\n\n'
_echo_primary '  alias ls="eza"\n'
_echo_primary '  alias ll="eza -l --git --icons"\n'
_echo_primary '  alias tree="eza --tree"\n'
