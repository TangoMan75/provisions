#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install handy
##
## the free and open source app for speech to text
##
## @category productivity
## @link     https://handy.computer
## @link     https://github.com/cjpais/Handy

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
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

APP_NAME=handy
AUTHOR=cjpais
REPOSITORY=${AUTHOR}/${APP_NAME}
DESKTOP=Handy.desktop

#--------------------------------------------------

DEFAULT_VERSION=0.7.5
VERSION=$(get_latest_release "${REPOSITORY}" || echo "${DEFAULT_VERSION}")
if [ -z "${VERSION}" ]; then
    VERSION="${DEFAULT_VERSION}"
fi

#--------------------------------------------------

ARCH=$(uname -m | sed 's/x86_64/amd64/; s/aarch64/arm64/')
REMOTE_FILE="${APP_NAME}_${VERSION}_${ARCH}.deb"
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

_echo_warning "Install dependencies\n"

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info 'sudo apt-get install -y libgtk-layer-shell0\n'
sudo apt-get install -y libgtk-layer-shell0

#--------------------------------------------------

_echo_warning "Install .deb package\n"

_echo_info "sudo dpkg -i \"${TEMP_DIR}/${ARCHIVE}\"\n"
sudo dpkg -i "${TEMP_DIR}/${ARCHIVE}"

#--------------------------------------------------

# create shortcut on desktop
_echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

