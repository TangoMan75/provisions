#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## brave
##
## Brave is a free and open source web browser based on the chromium project.
##
## @category browser
## @link     https://brave.com/linux

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=brave-browser
DESKTOP="${APP_NAME}".desktop

#--------------------------------------------------

KEYRING_URL=https://brave-browser-apt-release.s3.brave.com
KEYRING_FILE=brave-browser-archive-keyring.gpg
SOURCES_FILE=brave-browser-release.sources
SOURCES_URL_FILE=brave-browser.sources

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

_echo_warning 'Check dependencies\n'

if ! command -v curl &> /dev/null; then
  _echo_danger "curl not found, install it with: sudo apt install curl"
  exit 1
fi

#--------------------------------------------------

_echo_warning 'Install GPG keyring\n'

_echo_info "sudo curl -fsSLo /usr/share/keyrings/${KEYRING_FILE} ${KEYRING_URL}/${KEYRING_FILE}\n"
sudo curl -fsSLo "/usr/share/keyrings/${KEYRING_FILE}" "${KEYRING_URL}/${KEYRING_FILE}"

#--------------------------------------------------

_echo_warning 'Install APT sources\n'

_echo_info "sudo curl -fsSLo /etc/apt/sources.list.d/${SOURCES_FILE} ${KEYRING_URL}/${SOURCES_URL_FILE}\n"
sudo curl -fsSLo "/etc/apt/sources.list.d/${SOURCES_FILE}" "${KEYRING_URL}/${SOURCES_URL_FILE}"

#--------------------------------------------------

_echo_info 'sudo apt update\n'
sudo apt update

#--------------------------------------------------

_echo_info "sudo apt install --assume-yes ${APP_NAME}\n"
sudo apt install --assume-yes "${APP_NAME}"

#--------------------------------------------------

_echo_warning 'Create shortcut on desktop\n'

_echo_info "cp -p /usr/share/applications/${DESKTOP} $(xdg-user-dir DESKTOP)\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

