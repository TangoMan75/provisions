#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## bruno
##
## lightweight REST client and API testing tool
##
## @category network
## @link     https://www.usebruno.com
## @link     https://github.com/usebruno/bruno
## @link     https://marketplace.visualstudio.com/items?itemName=bruno-api-client.bruno

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(curl gpg)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

APP_NAME=bruno
DESKTOP=${APP_NAME}.desktop

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(curl gpg)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

_echo_warning 'Creating APT keyrings directory\n'

_echo_info "sudo mkdir -p /etc/apt/keyrings\n"
sudo mkdir -p /etc/apt/keyrings

#--------------------------------------------------

_echo_warning 'Adding Bruno repository GPG key\n'

_echo_info "curl -fsSL \"https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x9FA6017ECABE0266\" | gpg --dearmor | sudo tee /etc/apt/keyrings/bruno.gpg > /dev/null\n"
curl -fsSL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x9FA6017ECABE0266" | gpg --dearmor | sudo tee /etc/apt/keyrings/bruno.gpg > /dev/null

#--------------------------------------------------

_echo_warning 'Setting GPG key permissions\n'

_echo_info "sudo chmod 644 /etc/apt/keyrings/bruno.gpg\n"
sudo chmod 644 /etc/apt/keyrings/bruno.gpg

#--------------------------------------------------

_echo_warning 'Adding Bruno repository\n'

_echo_info "echo \"deb [arch=amd64 signed-by=/etc/apt/keyrings/bruno.gpg] http://debian.usebruno.com/ bruno stable\" | sudo tee /etc/apt/sources.list.d/bruno.list\n"
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/bruno.gpg] http://debian.usebruno.com/ bruno stable" | sudo tee /etc/apt/sources.list.d/bruno.list > /dev/null

#--------------------------------------------------

_echo_info 'sudo apt-get update\n'
sudo apt-get update

#--------------------------------------------------

_echo_info "sudo apt-get install -y ${APP_NAME}\n"
sudo apt-get install -y "${APP_NAME}"

#--------------------------------------------------

_echo_warning 'Create shortcut on desktop\n'

_echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

