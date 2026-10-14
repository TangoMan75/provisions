#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## docker-compose
##
## @link     https://github.com/docker/compose
## @category devops

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

#--------------------------------------------------

# Check for required commands
if [ ! -x "$(command -v curl)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'\n"
    exit 1
fi

#--------------------------------------------------

APP_NAME=compose
AUTHOR=docker
REPOSITORY="${AUTHOR}/${APP_NAME}"
BINARY="docker-${APP_NAME}"
DESTINATION="/usr/bin"

#--------------------------------------------------

VERSION=$(get_latest_release ${REPOSITORY})
if [ -z "${VERSION}" ]; then
    VERSION=5.1.4
fi

#--------------------------------------------------

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)
REMOTE_FILE="${BINARY}-${OS}-${ARCH}"
URL="https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${REMOTE_FILE}"

#--------------------------------------------------

_alert_primary "Install ${REPOSITORY} v${VERSION}"

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

_echo_warning 'Downloading file to temporary directory\n'

if [ -x "$(command -v curl)" ]; then
    # download latest version from github with curl
    _echo_info "curl -Lf \"${URL}\" -o \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
    curl -Lf "${URL}" -o "${TEMP_DIR}/${REMOTE_FILE}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    _echo_info "wget -q \"${URL}\" -O \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
    wget -q "${URL}" -O "${TEMP_DIR}/${REMOTE_FILE}"

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

# Check if the downloaded file is valid (not empty and not an HTML error page)
if [ ! -s "${TEMP_DIR}/${REMOTE_FILE}" ] || head -n 1 "${TEMP_DIR}/${REMOTE_FILE}" | grep -q "<!DOCTYPE html>"; then
    _echo_danger "error: Downloaded file is invalid or not found. Please check the architecture and URL.\n"
    _echo_info "Supported architectures: amd64, arm64\n"
    _echo_info "Your architecture: ${ARCH}\n"
    exit 1
fi

#--------------------------------------------------

_echo_warning "Move binary to \"${DESTINATION}\"\n"

_echo_info "sudo mv \"${TEMP_DIR}/${REMOTE_FILE}\" \"${DESTINATION}/${BINARY}\"\n"
sudo mv "${TEMP_DIR}/${REMOTE_FILE}" "${DESTINATION}/${BINARY}"

#--------------------------------------------------

_echo_warning "Setting executable permissions for \"${DESTINATION}/${BINARY}\"\n"

_echo_info "sudo chmod uga+x \"${DESTINATION}/${BINARY}\"\n"
sudo chmod uga+x "${DESTINATION}/${BINARY}"

#--------------------------------------------------

_echo_warning "create \"cli-plugins\" folder in \"$HOME/.docker\" directory\n"

_echo_info 'mkdir -p ~/.docker/cli-plugins/\n'
mkdir -p ~/.docker/cli-plugins/

#--------------------------------------------------

_echo_warning "create binary symlink into \"$HOME/.docker/cli-plugins\"\n"

_echo_info "ln -s \"${DESTINATION}/${BINARY}\" \"$HOME/.docker/cli-plugins/${BINARY}\"\n"
ln -s "${DESTINATION}/${BINARY}" "$HOME/.docker/cli-plugins/${BINARY}"

#--------------------------------------------------

_echo_warning 'Cleaning up temporary files\n'

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

# check command is properly installed
_echo_info "docker ${APP_NAME} version\n"
docker "${APP_NAME}" version
