#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## mailpit
##
## Install mailpit email testing tool
##
## @category servers
## @link     https://github.com/axllent/mailpit

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(curl tar wget)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

APP_NAME=mailpit
AUTHOR=axllent
REPOSITORY=${AUTHOR}/${APP_NAME}
BINARY="${APP_NAME}"
DESTINATION="/usr/local/bin"

#--------------------------------------------------

DEFAULT_VERSION=1.28.0
VERSION=$(get_latest_release "${REPOSITORY}" || echo "${DEFAULT_VERSION}")
if [ -z "${VERSION}" ]; then
    VERSION="${DEFAULT_VERSION}"
fi

#--------------------------------------------------

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m | sed 's/x86_64/amd64/; s/aarch64/arm64/')
REMOTE_FILE="${APP_NAME}-${OS}-${ARCH}.tar.gz"
ARCHIVE="${REMOTE_FILE}"
URL="https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${REMOTE_FILE}"

#--------------------------------------------------

alert_primary "Install ${APP_NAME} v${VERSION}"

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

echo_warning 'Downloading binary to temporary directory\n'

if [ -x "$(command -v curl)" ]; then
    # download with curl
    echo_info "curl -L \"${URL}\" -o \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
    if ! curl -L "${URL}" -o "${TEMP_DIR}/${REMOTE_FILE}"; then
        echo_danger "error: Failed to download ${REMOTE_FILE}\n"
        exit 1
    fi

elif [ -x "$(command -v wget)" ]; then
    # download with wget
    echo_info "wget -nv \"${URL}\" -O \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
    if ! wget -nv "${URL}" -O "${TEMP_DIR}/${REMOTE_FILE}"; then
        echo_danger "error: Failed to download ${REMOTE_FILE}\n"
        exit 1
    fi

else
    echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

# Check if the downloaded file is valid (not empty and not an HTML error page)
if [ ! -s "${TEMP_DIR}/${ARCHIVE}" ] || head -n 1 "${TEMP_DIR}/${ARCHIVE}" | grep -q "<!DOCTYPE html>"; then
    echo_danger "error: Downloaded file is invalid or not found. Please check the architecture and URL.\n"
    echo_info "Supported architectures: amd64, arm64\n"
    echo_info "Your architecture: $(uname -m)\n"
    exit 1
fi

#--------------------------------------------------

echo_warning "Extract \"${ARCHIVE}\"\n"

# extract with tar
echo_info "tar -xvzf \"${TEMP_DIR}/${ARCHIVE}\" -C \"${TEMP_DIR}\"\n"
tar -xvzf "${TEMP_DIR}/${ARCHIVE}" -C "${TEMP_DIR}"

#--------------------------------------------------

if [ ! -d "${DESTINATION}" ]; then
    echo_warning 'Create destination folder\n'

    echo_info "sudo mkdir -p \"${DESTINATION}\"\n"
    sudo mkdir -p "${DESTINATION}"
fi

#--------------------------------------------------

echo_warning "Move binary to \"${DESTINATION}\"\n"

echo_info "sudo mv \"${TEMP_DIR}/${BINARY}\" \"${DESTINATION}/${BINARY}\"\n"
sudo mv "${TEMP_DIR}/${BINARY}" "${DESTINATION}/${BINARY}"

#--------------------------------------------------

echo_warning "Setting executable permissions for ${BINARY}\n"

echo_info "sudo chmod uga+x \"${DESTINATION}/${BINARY}\"\n"
sudo chmod uga+x "${DESTINATION}/${BINARY}"

#--------------------------------------------------

echo_warning 'Cleaning up temporary files\n'

echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

echo_warning 'Update system\n'

echo_info 'sync\n'
sync