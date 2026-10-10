#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## DevToys
##
## @category   communication
## @link       https://devtoys.app
## @link       https://github.com/DevToys-app/DevToys

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

#--------------------------------------------------

APP_NAME=devtoys
AUTHOR=DevToys-app
REPOSITORY="${AUTHOR}/DevToys"
BINARY=${APP_NAME}_linux_x64.deb
DESKTOP=${APP_NAME}.desktop
DEFAULT_VERSION=2.0.9.0

#--------------------------------------------------

# get latest release from github
VERSION=$(get_latest_release "${REPOSITORY}")
if [ -z "${VERSION}" ] || [ "${VERSION}" = '1.0.13.0' ]; then
    VERSION=${DEFAULT_VERSION}
fi

#--------------------------------------------------

URL="https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${BINARY}"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME} v${VERSION}"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(dpkg)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

_echo_warning 'Downloading file to temporary directory\n'

if [ -x "$(command -v curl)" ]; then
    # download latest version from github with curl
    _echo_info "curl -Lf \"${URL}\" -o \"${TEMP_DIR}/${BINARY}\"\n"
    curl -Lf "${URL}" -o "${TEMP_DIR}/${BINARY}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    _echo_info "wget -q \"${URL}\" -O \"${TEMP_DIR}/${BINARY}\"\n"
    wget -q "${URL}" -O "${TEMP_DIR}/${BINARY}"

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

# Check if the downloaded file is valid (not empty and not an HTML error page)
if [ ! -s "${TEMP_DIR}/${BINARY}" ] || head -n 1 "${TEMP_DIR}/${BINARY}" | grep -q "<!DOCTYPE html>"; then
    _echo_danger "error: Downloaded file is invalid or not found.\n"
    exit 1
fi

#--------------------------------------------------

_echo_info "sudo dpkg -i \"${TEMP_DIR}/${BINARY}\"\n"
sudo dpkg -i "${TEMP_DIR}/${BINARY}"

#--------------------------------------------------

_echo_warning 'Fix missing dependencies if any\n'

_echo_info 'sudo apt-get install -f -y\n'
sudo apt-get install -f -y

#--------------------------------------------------

_echo_warning "Cleaning up temporary files\n"

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

_echo_warning 'Create shortcut on desktop\n'

_echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

