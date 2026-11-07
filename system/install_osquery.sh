#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## osquery
##
## Multi-platform system information with SQL queries
##
## @category system
## @link     https://osquery.io

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

KEY_ID=1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B
KEYRING=osquery.gpg

#--------------------------------------------------

if [ ! -x "$(command -v gpg)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires gpg, try: 'sudo apt-get install -y gpg'\n"
    exit 1
fi

# fetch the key in a temporary keyring (apt-key is gone since Debian 12 / Ubuntu 24.04)
TEMP_GNUPGHOME=$(mktemp -d)

_echo_info 'sudo mkdir -p -m 755 /etc/apt/keyrings\n'
sudo mkdir -p -m 755 /etc/apt/keyrings

_echo_info "gpg --batch --homedir \"${TEMP_GNUPGHOME}\" --keyserver keyserver.ubuntu.com --recv-keys ${KEY_ID}\n"
gpg --batch --homedir "${TEMP_GNUPGHOME}" --keyserver keyserver.ubuntu.com --recv-keys "${KEY_ID}"

_echo_info "gpg --batch --homedir \"${TEMP_GNUPGHOME}\" --export ${KEY_ID} | sudo tee \"/etc/apt/keyrings/${KEYRING}\" > /dev/null\n"
gpg --batch --homedir "${TEMP_GNUPGHOME}" --export "${KEY_ID}" | sudo tee "/etc/apt/keyrings/${KEYRING}" > /dev/null

_echo_info "rm -rf \"${TEMP_GNUPGHOME}\"\n"
rm -rf "${TEMP_GNUPGHOME}"

_echo_info "echo \"deb [arch=amd64 signed-by=/etc/apt/keyrings/${KEYRING}] https://pkg.osquery.io/deb deb main\" | sudo tee /etc/apt/sources.list.d/osquery.list > /dev/null\n"
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/${KEYRING}] https://pkg.osquery.io/deb deb main" | sudo tee /etc/apt/sources.list.d/osquery.list > /dev/null

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info 'sudo apt install -y osquery\n'
sudo apt install -y osquery

