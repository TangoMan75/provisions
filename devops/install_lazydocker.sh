#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## lazydocker
##
## @link     https://github.com/jesseduffield/lazydocker
## @category devops

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

#--------------------------------------------------

APP_NAME=lazydocker
AUTHOR=jesseduffield
REPOSITORY=${AUTHOR}/${APP_NAME}
BINARY="${APP_NAME}"
DESTINATION="${HOME}/.local/bin"

#--------------------------------------------------

DEFAULT_VERSION=0.24.1
VERSION=$(get_latest_release "${REPOSITORY}" || echo "${DEFAULT_VERSION}")
if [ -z "${VERSION}" ]; then
    VERSION="${DEFAULT_VERSION}"
fi

#--------------------------------------------------

REMOTE_FILE="${APP_NAME}_${VERSION}_$(uname -s)_$(uname -m).tar.gz"
ARCHIVE="${REMOTE_FILE}"
URL="https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${REMOTE_FILE}"

#--------------------------------------------------

_alert_primary "Install ${PROJECT} v${VERSION}"

#--------------------------------------------------

if ! command -v tar &> /dev/null; then
    _echo_danger "error: \"$(basename "${0}")\" requires tar, try: 'sudo apt-get install -y tar'\n"
    exit 1
fi

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

_echo_warning 'Downloading file to temporary directory\n'

if [ -x "$(command -v curl)" ]; then
    # download latest version from github with curl
    _echo_info "curl -L \"${URL}\" -o \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
    curl -L "${URL}" -o "${TEMP_DIR}/${REMOTE_FILE}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    _echo_info "wget -nv \"${URL}\" -O \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
    wget -nv "${URL}" -O "${TEMP_DIR}/${REMOTE_FILE}"

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
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

_echo_warning 'Update system\n'

_echo_info 'sync\n'
sync

