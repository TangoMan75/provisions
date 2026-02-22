#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## VirtualBox
##
## @category devops
## @link     https://www.virtualbox.org/wiki/Linux_Downloads

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=virtualbox
URL="https://download.virtualbox.org/virtualbox/7.2.4/virtualbox-7.2_7.2.4-170995~Ubuntu~noble_amd64.deb"
BINARY=virtualbox-7.2_7.2.4-170995~Ubuntu~noble_amd64.deb
DESKTOP=virtualbox.desktop

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

_alert_info 'Install VirtualBox Dependencies'

#--------------------------------------------------

_echo_info 'sudo apt-get update\n'
sudo apt-get update

#--------------------------------------------------

_echo_info "sudo apt-get install --reinstall linux-headers-\"$(uname -r)\"\n"
sudo apt-get install --reinstall linux-headers-"$(uname -r)"

#--------------------------------------------------

_echo_info 'sudo apt-get install --assume-yes build-essential\n'
sudo apt-get install --assume-yes build-essential

#--------------------------------------------------

# Provides the infrastructure to automatically rebuild kernel modules when the kernel changes.

_echo_info 'sudo apt-get install --assume-yes dkms\n'
sudo apt-get install --assume-yes dkms

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
    _echo_info "curl -L \"${URL}\" -o \"${TEMP_DIR}/${BINARY}\"\n"
    curl -L "${URL}" -o "${TEMP_DIR}/${BINARY}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    _echo_info "wget -nv \"${URL}\" -O \"${TEMP_DIR}/${BINARY}\"\n"
    wget -nv "${URL}" -O "${TEMP_DIR}/${BINARY}"

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

#--------------------------------------------------

# install package a first time
_echo_info "sudo dpkg -i \"${TEMP_DIR}/${BINARY}\"\n"
sudo dpkg -i "${TEMP_DIR}/${BINARY}"

#--------------------------------------------------

_echo_warning 'Fix missing dependencies\n'

_echo_info 'sudo apt-get --fix-broken --assume-yes install\n'
sudo apt-get --fix-broken --assume-yes install

#--------------------------------------------------

# dpkg needs to be executed a second time to resume install
_echo_info "sudo dpkg -i \"${TEMP_DIR}/${BINARY}\"\n"
sudo dpkg -i "${TEMP_DIR}/${BINARY}"

#--------------------------------------------------

_echo_warning "Cleaning up temporary files\n"

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

_echo_warning 'Create shortcut on desktop\n'

_echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

#--------------------------------------------------

_alert_info 'Setup VirtualBox'

#--------------------------------------------------

_echo_warning 'Setup VirtualBox Linux kernel driver\n'

_echo_info 'sudo /sbin/vboxconfig\n'
sudo /sbin/vboxconfig

#--------------------------------------------------

_echo_warning 'Load VirtualBox driver\n'

_echo_info 'sudo modprobe vboxdrv\n'
sudo modprobe vboxdrv
