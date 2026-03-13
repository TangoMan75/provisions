#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## copyous
##
## Modern Clipboard Manager for GNOME
##
## @category system
## @link     https://github.com/boerdereinar/copyous
## @link     https://extensions.gnome.org/extension/8834/copyous/

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(gnome-extensions curl)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

APP_NAME=copyous
AUTHOR=boerdereinar
REPOSITORY=${AUTHOR}/${APP_NAME}
EXTENSION_UUID="${APP_NAME}@${AUTHOR}.dev"

#--------------------------------------------------

DEFAULT_VERSION=1.3.0
VERSION=$(get_latest_release "${REPOSITORY}" || echo "${DEFAULT_VERSION}")
if [ -z "${VERSION}" ]; then
    VERSION="${DEFAULT_VERSION}"
fi

#--------------------------------------------------

ARCHIVE="copyous@${AUTHOR}.dev.zip"
URL="https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${ARCHIVE}"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME} v${VERSION}"

#--------------------------------------------------

_echo_warning 'Install required system packages\n'

_echo_info "sudo apt-get install -y gir1.2-gda-5.0 gir1.2-gsound-1.0\n"
sudo apt-get install -y gir1.2-gda-5.0 gir1.2-gsound-1.0

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

_echo_warning 'Downloading file to temporary directory\n'

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -sSLf \"${URL}\" -o \"${TEMP_DIR}/${ARCHIVE}\"\n"
    curl -sSLf "${URL}" -o "${TEMP_DIR}/${ARCHIVE}"

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -q \"${URL}\" -O \"${TEMP_DIR}/${ARCHIVE}\"\n"
    wget -q "${URL}" -O "${TEMP_DIR}/${ARCHIVE}"
fi

#--------------------------------------------------

_echo_warning "Install extension\n"

_echo_info "gnome-extensions install -f \"${TEMP_DIR}/${ARCHIVE}\"\n"
gnome-extensions install -f "${TEMP_DIR}/${ARCHIVE}"

#--------------------------------------------------

_echo_warning 'Cleaning up temporary files\n'

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

if gnome-extensions list | grep -q "${EXTENSION_UUID}"; then
    _echo_info "gnome-extensions enable ${EXTENSION_UUID}\n"
    gnome-extensions enable "${EXTENSION_UUID}"
else
    _echo_warning 'Extension installed but not yet recognized. It will be available after restarting the GNOME session.\n'
fi

#--------------------------------------------------

_echo_success 'Copyous has been installed.\n'
_echo_warning 'Please restart your GNOME session to use the extension.\n'
_echo_warning 'You can open the extension settings either through the panel indicator, "Extension Manager" or by running the following command:\n'
_echo_info 'gnome-extensions prefs copyous@boerdereinar.dev\n'
