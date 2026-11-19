#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## fingerprint reader
##
## @category drivers

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v gpg)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires gpg, try: 'sudo apt-get install -y gpg'\n"
    exit 1
fi

#--------------------------------------------------

KEY_ID=F9FDA6BED73CDC22
KEYRING=dell-somerville.gpg

#--------------------------------------------------

_echo_info 'sudo mkdir -p -m 755 /etc/apt/keyrings\n'
sudo mkdir -p -m 755 /etc/apt/keyrings

# fetch the key in a temporary keyring (apt-key is gone since Debian 12 / Ubuntu 24.04)
TEMP_GNUPGHOME=$(mktemp -d)

_echo_info "gpg --batch --homedir \"${TEMP_GNUPGHOME}\" --keyserver keyserver.ubuntu.com --recv-keys ${KEY_ID}\n"
gpg --batch --homedir "${TEMP_GNUPGHOME}" --keyserver keyserver.ubuntu.com --recv-keys "${KEY_ID}"

_echo_info "gpg --batch --homedir \"${TEMP_GNUPGHOME}\" --export ${KEY_ID} | sudo tee \"/etc/apt/keyrings/${KEYRING}\" > /dev/null\n"
gpg --batch --homedir "${TEMP_GNUPGHOME}" --export "${KEY_ID}" | sudo tee "/etc/apt/keyrings/${KEYRING}" > /dev/null

_echo_info "rm -rf \"${TEMP_GNUPGHOME}\"\n"
rm -rf "${TEMP_GNUPGHOME}"

#--------------------------------------------------

_echo_info "sudo sh -c \"cat > /etc/apt/sources.list.d/$(lsb_release -cs 2>/dev/null)-dell.list << EOF\"\n"
sudo sh -c "cat > /etc/apt/sources.list.d/$(lsb_release -cs 2>/dev/null)-dell.list << EOF
deb [signed-by=/etc/apt/keyrings/${KEYRING}] http://dell.archive.canonical.com/updates/ $(lsb_release -cs 2>/dev/null)-dell public
deb [signed-by=/etc/apt/keyrings/${KEYRING}] http://dell.archive.canonical.com/updates/ $(lsb_release -cs 2>/dev/null)-oem public
deb [signed-by=/etc/apt/keyrings/${KEYRING}] http://dell.archive.canonical.com/updates/ $(lsb_release -cs 2>/dev/null)-somerville public
deb [signed-by=/etc/apt/keyrings/${KEYRING}] http://dell.archive.canonical.com/updates/ $(lsb_release -cs 2>/dev/null)-somerville-melisa public
EOF"

_echo_info 'sudo apt update -qq\n'
sudo apt update -qq

_echo_info 'sudo apt install -y oem-somerville-melisa-meta\n'
sudo apt install -y oem-somerville-melisa-meta

_echo_info 'sudo apt install -y libfprint-2-tod1-goodix\n'
sudo apt install -y libfprint-2-tod1-goodix

_echo_info 'sudo apt install -y oem-somerville-meta\n'
sudo apt install -y oem-somerville-meta

#--------------------------------------------------

_echo_info 'sudo apt install -y tlp-config\n'
sudo apt install -y tlp-config

#--------------------------------------------------

_echo_info 'sudo add-apt-repository --yes ppa:boltgolt/howdy -y\n'
sudo add-apt-repository --yes ppa:boltgolt/howdy -y

_echo_info 'sudo apt update -qq\n'
sudo apt update -qq

_echo_info 'sudo apt install howdy -y\n'
sudo apt install howdy -y
