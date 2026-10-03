#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## mongodb-org
## database server
##
## ```
## # Verify that MongoDB has started successfully.
## $ sudo systemctl status mongod
## # Autostart after reboot
## $ sudo systemctl enable mongod
## ```
##
## @category servers
## @link https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

_echo_info 'sudo apt-get install --assume-yes gnupg\n'
sudo apt-get install --assume-yes gnupg

#--------------------------------------------------

KEYRING_URL=https://www.mongodb.org/static/pgp/server-4.4.asc
KEYRING=mongodb-org-4.4.gpg

#--------------------------------------------------

# import the public key used by the package management system
# (apt-key is gone since Debian 12 / Ubuntu 24.04)
_echo_info 'sudo mkdir -p -m 755 /etc/apt/keyrings\n'
sudo mkdir -p -m 755 /etc/apt/keyrings

_echo_info "wget -qO- \"${KEYRING_URL}\" | sudo gpg --batch --yes --dearmor -o \"/etc/apt/keyrings/${KEYRING}\"\n"
wget -qO- "${KEYRING_URL}" | sudo gpg --batch --yes --dearmor -o "/etc/apt/keyrings/${KEYRING}"

# create a list file for MongoDB
_echo_info "echo 'deb [arch=amd64,arm64 signed-by=/etc/apt/keyrings/${KEYRING}] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse' | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list > /dev/null\n"
echo "deb [arch=amd64,arm64 signed-by=/etc/apt/keyrings/${KEYRING}] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list > /dev/null

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info 'sudo apt-get install --assume-yes mongodb-org\n'
sudo apt-get install --assume-yes mongodb-org

