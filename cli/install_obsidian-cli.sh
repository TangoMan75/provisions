#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install_obsidian-cli
##
## Install obsidian-cli from GitHub releases
##
## @category cli
## @link     https://github.com/Yakitrak/obsidian-cli

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

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

APP_NAME=obsidian-cli
AUTHOR=Yakitrak
REPOSITORY=${AUTHOR}/${APP_NAME}
BINARY="${APP_NAME}"
DESTINATION=/usr/bin

#--------------------------------------------------

DEFAULT_VERSION=0.2.2
VERSION=$(get_latest_release "${REPOSITORY}" || echo "${DEFAULT_VERSION}")
if [ -z "${VERSION}" ]; then
    VERSION="${DEFAULT_VERSION}"
fi

#--------------------------------------------------

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m | sed 's/x86_64/amd64/; s/aarch64/arm64/')
REMOTE_FILE="${APP_NAME}_${VERSION}_${OS}_${ARCH}.tar.gz"
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

# Check if the downloaded file is valid (not empty and not an HTML error page)
if [ ! -s "${TEMP_DIR}/${ARCHIVE}" ] || head -n 1 "${TEMP_DIR}/${ARCHIVE}" | grep -q "<!DOCTYPE html>"; then
    _echo_danger "error: Downloaded file is invalid or not found. Please check the architecture and URL.\n"
    _echo_info "Supported architectures: amd64, arm64\n"
    _echo_info "Your architecture: $(uname -m)\n"
    exit 1
fi

#--------------------------------------------------

_echo_warning "Extract \"${ARCHIVE}\"\n"

# Extract file based on its extension
#
# ${ARCHIVE##*.} : This is a parameter expansion expression
#             ## : Removes the shortest pattern that matches the entire string from the end of the value
#              * : Matches zero or more characters
#              . : Matches a literal dot (.)
case "${ARCHIVE##*.}" in
    gz)
        if ! command -v tar &> /dev/null; then
            _echo_danger "error: \"$(basename "${0}")\" requires tar, try: 'sudo apt-get install -y tar'\n"
            exit 1
        fi

        # extract with tar
        # -x, --extract
        # -v, --verbose
        # -z, --gzip, --gunzip --ungzip
        # -f, --file [ARCHIVE]
        # -C, --directory [DIR] : destination directory
        _echo_info "tar -xvzf \"${TEMP_DIR}/${ARCHIVE}\" -C \"${TEMP_DIR}\"\n"
        tar -xvzf "${TEMP_DIR}/${ARCHIVE}" -C "${TEMP_DIR}"
        ;;
    zip)
        if ! command -v unzip &> /dev/null; then
            _echo_danger "error: \"$(basename "${0}")\" requires unzip, try: 'sudo apt-get install -y unzip'\n"
            exit 1
        fi

        _echo_info "unzip \"${TEMP_DIR}/${ARCHIVE}\" -d \"${TEMP_DIR}\"\n"
        unzip "${TEMP_DIR}/${ARCHIVE}" -d "${TEMP_DIR}"
        ;;
    *)
        _echo_danger "error: Unsupported archive format \"${ARCHIVE##*.}\".\n"
        exit 1
        ;;
esac

#--------------------------------------------------

if [ ! -d "${DESTINATION}" ]; then
    _echo_warning 'Create destination folder\n'

    _echo_info "sudo mkdir -p \"${DESTINATION}\"\n"
    sudo mkdir -p "${DESTINATION}"
fi

#--------------------------------------------------

_echo_warning "Move binary to \"${DESTINATION}\"\n"

_echo_info "sudo mv \"${TEMP_DIR}/${BINARY}\" \"${DESTINATION}\"\n"
sudo mv "${TEMP_DIR}/${BINARY}" "${DESTINATION}"

#--------------------------------------------------

_echo_warning "Setting executable permissions for ${BINARY}\n"

_echo_info "sudo chmod uga+x \"${DESTINATION}/${BINARY}\"\n"
sudo chmod uga+x "${DESTINATION}/${BINARY}"

#--------------------------------------------------

_echo_warning 'Cleaning up temporary files\n'

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

_echo_warning 'Update system\n'

_echo_info 'sync\n'
sync