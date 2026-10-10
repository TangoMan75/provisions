#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## mysql-server
## database server
##
## @category servers

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=postgresql
APP_NAME_2=postgresql-contrib

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

if [ ! -x "$(command -v gpg)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires gpg, try: 'sudo apt-get install -y gpg'\n"
    exit 1
fi

#--------------------------------------------------

_echo_info 'sudo apt-get install --assume-yes wget ca-certificates\n'
sudo apt-get install --assume-yes wget ca-certificates

#--------------------------------------------------

KEYRING_URL=https://www.postgresql.org/media/keys/ACCC4CF8.asc
KEYRING=pgdg.gpg

#--------------------------------------------------

# install the gpg key in a dedicated keyring (apt-key is gone since Debian 12 / Ubuntu 24.04)
_echo_info 'sudo mkdir -p -m 755 /etc/apt/keyrings\n'
sudo mkdir -p -m 755 /etc/apt/keyrings

_echo_info "wget --quiet -O- \"${KEYRING_URL}\" | sudo gpg --batch --yes --dearmor -o \"/etc/apt/keyrings/${KEYRING}\"\n"
wget --quiet -O- "${KEYRING_URL}" | sudo gpg --batch --yes --dearmor -o "/etc/apt/keyrings/${KEYRING}"

_echo_info "echo \"deb [signed-by=/etc/apt/keyrings/${KEYRING}] http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main\" | sudo tee /etc/apt/sources.list.d/pgdg.list > /dev/null\n"
echo "deb [signed-by=/etc/apt/keyrings/${KEYRING}] http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list > /dev/null

_echo_info 'sudo apt-get update\n'
sudo apt-get update

#--------------------------------------------------

_echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"

_echo_info "sudo apt-get install --assume-yes \"${APP_NAME_2}\"\n"
sudo apt-get install --assume-yes "${APP_NAME_2}"

