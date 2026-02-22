#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install vibe
##
## Experience seamless language transcription with Vibe - your all-in-one solution for effortless audio and video transcription.
##
## @category productivity
## @link     https://thewh1teagle.github.io/vibe
## @link     https://github.com/thewh1teagle/vibe

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

#--------------------------------------------------

APP_NAME=vibe
AUTHOR=thewh1teagle
REPOSITORY=${AUTHOR}/${APP_NAME}
DESKTOP="${APP_NAME}.desktop"

#--------------------------------------------------

DEFAULT_VERSION=3.0.11
VERSION=$(get_latest_release "${REPOSITORY}" || echo "${DEFAULT_VERSION}")
if [ -z "${VERSION}" ]; then
    VERSION="${DEFAULT_VERSION}"
fi

#--------------------------------------------------

_alert_primary "Installing ${APP_NAME} v${VERSION}"

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -LsSf https://${AUTHOR}.github.io/${APP_NAME}/installer.sh | sh -s \"v${VERSION}\"\n"
    curl -LsSf https://${AUTHOR}.github.io/${APP_NAME}/installer.sh | sh -s "v${VERSION}"

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -qO- https://${AUTHOR}.github.io/${APP_NAME}/installer.sh | sh -s \"v${VERSION}\"\n"
    wget -qO- https://${AUTHOR}.github.io/${APP_NAME}/installer.sh | sh -s "v${VERSION}"

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

#--------------------------------------------------

_echo_info 'sudo apt-get --fix-broken install\n'
sudo apt-get --fix-broken install

#--------------------------------------------------

_echo_warning 'Create shortcut on desktop\n'

_echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

