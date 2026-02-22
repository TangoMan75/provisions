#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install ksnip
## simple picture editor
##
## @category graphics

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

#--------------------------------------------------

PROJECT=ksnip
AUTHOR=ksnip
REPOSITORY=${AUTHOR}/${PROJECT}
DESKTOP=org.ksnip.ksnip.desktop

#--------------------------------------------------

DEFAULT_VERSION=1.10.1
VERSION=$(get_latest_release ${REPOSITORY})
if [ -z "${VERSION}" ]; then
    VERSION="${DEFAULT_VERSION}"
fi

#--------------------------------------------------

REMOTE_FILE="${PROJECT}-${VERSION}.deb"

#--------------------------------------------------

# Download release
URL="https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${REMOTE_FILE}"

#--------------------------------------------------

_alert_primary "Install ${PROJECT} v${VERSION}"

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    # download latest version from github with curl
    _echo_info "curl -L \"${URL}\" -o \"${REMOTE_FILE}\"\n"
    curl -L "${URL}" -o "${REMOTE_FILE}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    _echo_info "wget -nv \"${URL}\" -O \"${REMOTE_FILE}\"\n"
    wget -nv "${URL}" -O "${REMOTE_FILE}"
fi

#--------------------------------------------------

_echo_info "sudo dpkg --install \"${REMOTE_FILE}\"\n"
sudo dpkg --install "${REMOTE_FILE}"

_echo_info "rm -f \"${REMOTE_FILE}\"\n"
rm -f "${REMOTE_FILE}"

#--------------------------------------------------

# create shortcut on desktop
_echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

