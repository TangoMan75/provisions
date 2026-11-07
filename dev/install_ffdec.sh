#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## JPEXS Free Flash Decompiler
##
## Open Source Flash SWF decompiler and editor. Extract resources, convert
## SWF to FLA, edit ActionScript, replace images, sounds, texts and fonts.
## Various output formats available. Works with Java on Windows, Linux and macOS.
##
## ```
## # example usage
## ffdec -cli -swf2xml input.swf output.xml
## ```
##
## @category dev
## @link     https://github.com/jindrapetrik/jpexs-decompiler
## @link     https://github.com/jindrapetrik/jpexs-decompiler/wiki/Installation

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

#--------------------------------------------------

APP_NAME=ffdec
AUTHOR=jindrapetrik
REPOSITORY=${AUTHOR}/jpexs-decompiler
DESKTOP="${APP_NAME}.desktop"

#--------------------------------------------------

VERSION=$(get_latest_release "${REPOSITORY}")
if [ -z "${VERSION}" ]; then
    VERSION=26.3.0
fi

#--------------------------------------------------

REMOTE_FILE="${APP_NAME}_${VERSION}.deb"
ARCHIVE="${REMOTE_FILE}"
URL="https://github.com/${REPOSITORY}/releases/download/version${VERSION}/${REMOTE_FILE}"

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

_echo_warning "Downloading ${ARCHIVE} to temporary directory\n"

if [ -x "$(command -v curl)" ]; then
    # download latest version from github with curl
    _echo_info "curl -Lf \"${URL}\" -o \"${TEMP_DIR}/${ARCHIVE}\"\n"
    curl -Lf "${URL}" -o "${TEMP_DIR}/${ARCHIVE}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    _echo_info "wget -q \"${URL}\" -O \"${TEMP_DIR}/${ARCHIVE}\"\n"
    wget -q "${URL}" -O "${TEMP_DIR}/${ARCHIVE}"

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

# Check if the downloaded file is valid (not empty and not an HTML error page)
if [ ! -s "${TEMP_DIR}/${ARCHIVE}" ] || head -n 1 "${TEMP_DIR}/${ARCHIVE}" | grep -q "<!DOCTYPE html>"; then
    _echo_danger "error: Downloaded file is invalid or not found. Please check the URL.\n"
    exit 1
fi

#--------------------------------------------------

_echo_info "sudo dpkg -i \"${TEMP_DIR}/${ARCHIVE}\"\n"
sudo dpkg -i "${TEMP_DIR}/${ARCHIVE}"

#--------------------------------------------------

_echo_warning 'Fix missing dependencies if any\n'

_echo_info 'sudo apt-get install -f -y\n'
sudo apt-get install -f -y

#--------------------------------------------------

_echo_warning 'Cleaning up temporary files\n'

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

# Create shortcut on desktop
if [ -f "/usr/share/applications/${DESKTOP}" ]; then
    _echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
    cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"
else
    _echo_warning "Desktop entry \"/usr/share/applications/${DESKTOP}\" not found, skipping shortcut creation\n"
fi

#--------------------------------------------------

_echo_info 'ffdec requires Java, install it with: ./dev/install_java-jdk.sh\n'
