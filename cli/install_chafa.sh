#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## chafa
##
## Terminal graphics for the 21st century
##
## Chafa is a command-line utility that converts image data, including animated
## GIFs, into graphics formats or ANSI/Unicode character art suitable for display
## in a terminal. It has broad feature support, allowing it to be used on devices
## ranging from historical teleprinters to modern terminal emulators.
##
## @category cli
## @link     https://github.com/hpjansson/chafa
## @link     https://hpjansson.org/chafa/

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=chafa
DESTINATION="${HOME}/.local/bin"
DEFAULT_VERSION=1.18.1

#--------------------------------------------------

_alert_primary "Install ${APP_NAME} v${DEFAULT_VERSION}"

#--------------------------------------------------

if ! command -v tar &> /dev/null; then
    _echo_danger "error: \"$(basename "${0}")\" requires tar, try: 'sudo apt-get install -y tar'\n"
    exit 1
fi

#--------------------------------------------------

ARCH=$(uname -m)
case "${ARCH}" in
    x86_64)
        ARCH_NAME="x86_64"
        ;;
    armv7l)
        ARCH_NAME="armv7l"
        ;;
    aarch64)
        _echo_warning "No static binary for aarch64, using armv7l\n"
        ARCH_NAME="armv7l"
        ;;
    *)
        _echo_danger "error: Unsupported architecture: ${ARCH}\n"
        exit 1
        ;;
esac

#--------------------------------------------------

VERSION="${DEFAULT_VERSION}"
REMOTE_FILE="chafa-${VERSION}-1-${ARCH_NAME}-linux-gnu.tar.gz"
URL="https://hpjansson.org/chafa/releases/static/${REMOTE_FILE}"
ARCHIVE="${REMOTE_FILE}"

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

_echo_warning "Downloading ${APP_NAME} from ${URL}\n"

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -L \"${URL}\" -o \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
    curl -L "${URL}" -o "${TEMP_DIR}/${REMOTE_FILE}"

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -nv \"${URL}\" -O \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
    wget -nv "${URL}" -O "${TEMP_DIR}/${REMOTE_FILE}"

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    rm -rf "${TEMP_DIR}"
    exit 1
fi

#--------------------------------------------------

if [ ! -s "${TEMP_DIR}/${ARCHIVE}" ]; then
    _echo_danger "error: Downloaded file is empty or not found.\n"
    rm -rf "${TEMP_DIR}"
    exit 1
fi

#--------------------------------------------------

_echo_warning "Extract \"${ARCHIVE}\"\n"

_echo_info "tar -xzf \"${TEMP_DIR}/${ARCHIVE}\" -C \"${TEMP_DIR}\"\n"
tar -xzf "${TEMP_DIR}/${ARCHIVE}" -C "${TEMP_DIR}"

EXTRACTED_DIR="${TEMP_DIR}/${APP_NAME}-${VERSION}-1-${ARCH_NAME}-linux-gnu"

#--------------------------------------------------

if [ ! -d "${DESTINATION}" ]; then
    _echo_warning 'Create destination folder\n'

    _echo_info "mkdir -p \"${DESTINATION}\"\n"
    mkdir -p "${DESTINATION}"
fi

#--------------------------------------------------

_echo_warning "Move binary to \"${DESTINATION}\"\n"

_echo_info "mv \"${EXTRACTED_DIR}/${APP_NAME}\" \"${DESTINATION}\"\n"
mv "${EXTRACTED_DIR}/${APP_NAME}" "${DESTINATION}"

#--------------------------------------------------

_echo_warning "Setting executable permissions for ${APP_NAME}\n"

_echo_info "chmod uga+x \"${DESTINATION}/${APP_NAME}\"\n"
chmod uga+x "${DESTINATION}/${APP_NAME}"

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

#--------------------------------------------------

_echo_warning 'Update system\n'

_echo_info 'sync\n'
sync
