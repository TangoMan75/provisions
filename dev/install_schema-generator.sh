#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## schema-generator
##
## Api Platform Schema Generator as a standalone PHAR execuable
##
## @category dev
## @link     https://github.com/api-platform/schema-generator

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(curl wget)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

APP_NAME=schema-generator
AUTHOR=api-platform
REPOSITORY=${AUTHOR}/${APP_NAME}
BINARY="schema.phar"
DESTINATION=/usr/local/bin

#--------------------------------------------------

DEFAULT_VERSION=5.2.4
VERSION=$(get_latest_release "${REPOSITORY}" || echo "${DEFAULT_VERSION}")
if [ -z "${VERSION}" ]; then
    VERSION="${DEFAULT_VERSION}"
fi

#--------------------------------------------------

REMOTE_FILE="${BINARY}"
URL="https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${REMOTE_FILE}"

#--------------------------------------------------

alert_primary "Install ${APP_NAME} v${VERSION}"

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

echo_warning 'Downloading PHAR file to temporary directory\n'

if [ -x "$(command -v curl)" ]; then
    echo_info "curl -L \"${URL}\" -o \"${TEMP_DIR}/${BINARY}\"\n"
    curl -L "${URL}" -o "${TEMP_DIR}/${BINARY}"

elif [ -x "$(command -v wget)" ]; then
    echo_info "wget -nv \"${URL}\" -O \"${TEMP_DIR}/${BINARY}\"\n"
    wget -nv "${URL}" -O "${TEMP_DIR}/${BINARY}"

else
    echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

# Check if the downloaded file is valid (not empty and not an HTML error page)
if [ ! -s "${TEMP_DIR}/${BINARY}" ] || head -n 1 "${TEMP_DIR}/${BINARY}" | grep -q "<!DOCTYPE html>"; then
    echo_danger "error: Downloaded file is invalid or not found. Please check the URL.\n"
    exit 1
fi

#--------------------------------------------------

if [ ! -d "${DESTINATION}" ]; then
    echo_warning 'Create destination folder\n'

    echo_info "sudo mkdir -p \"${DESTINATION}\"\n"
    sudo mkdir -p "${DESTINATION}"
fi

#--------------------------------------------------

echo_warning "Move binary to \"${DESTINATION}\"\n"

echo_info "sudo mv \"${TEMP_DIR}/${BINARY}\" \"${DESTINATION}\"\n"
sudo mv "${TEMP_DIR}/${BINARY}" "${DESTINATION}"

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

