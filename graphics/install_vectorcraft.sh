#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## VectorCraft
##
## Fast, open-source vector illustration, reimagined in pure Rust.
##
## @category graphics
## @link     https://github.com/storytold/vectorcraft
## @link     https://getartcraft.com/apps/vectorcraft

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(curl dpkg)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

APP_NAME=vectorcraft
AUTHOR=storytold
REPOSITORY="${AUTHOR}/${APP_NAME}"
DEFAULT_VERSION=0.11.0

#--------------------------------------------------

VERSION=$(get_latest_release "${REPOSITORY}")
if [ -z "${VERSION}" ]; then
    VERSION=${DEFAULT_VERSION}
fi

#--------------------------------------------------

ARCH=$(uname -m)
DEB="${APP_NAME}-${VERSION}-linux-${ARCH}.deb"
URL="https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${DEB}"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME} v${VERSION}"

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

_echo_warning 'Downloading file to temporary directory\n'

if [ -x "$(command -v curl)" ]; then
    # download latest version from github with curl
    _echo_info "curl -Lf \"${URL}\" -o \"${TEMP_DIR}/${DEB}\"\n"
    curl -Lf "${URL}" -o "${TEMP_DIR}/${DEB}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    _echo_info "wget -q \"${URL}\" -O \"${TEMP_DIR}/${DEB}\"\n"
    wget -q "${URL}" -O "${TEMP_DIR}/${DEB}"

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

#--------------------------------------------------

# Check if the downloaded file is valid (not empty and not an HTML error page)
if [ ! -s "${TEMP_DIR}/${DEB}" ] || head -n 1 "${TEMP_DIR}/${DEB}" | grep -q "<!DOCTYPE html>"; then
    _echo_danger "error: Downloaded file is invalid or not found. Please check the version and URL.\n"
    _echo_info "Your architecture: ${ARCH}\n"
    exit 1
fi

#--------------------------------------------------

_echo_info "sudo dpkg -i \"${TEMP_DIR}/${DEB}\"\n"
sudo dpkg -i "${TEMP_DIR}/${DEB}"

#--------------------------------------------------

_echo_warning 'Fix missing dependencies if any\n'

_echo_info 'sudo apt-get install -f -y\n'
sudo apt-get install -f -y

#--------------------------------------------------

_echo_warning 'Cleaning up temporary files\n'

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

_echo_warning 'Create shortcut on desktop\n'

DESKTOP="ai.storyteller.${APP_NAME}.desktop"
if [ -f "/usr/share/applications/${DESKTOP}" ]; then
    _echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
    cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

elif [ -f "/usr/share/applications/${APP_NAME}.desktop" ]; then
    _echo_info "cp -p \"/usr/share/applications/${APP_NAME}.desktop\" \"$(xdg-user-dir DESKTOP)\"\n"
    cp -p "/usr/share/applications/${APP_NAME}.desktop" "$(xdg-user-dir DESKTOP)"

else
    _echo_warning "No desktop entry found for \"${APP_NAME}\"\n"
fi
