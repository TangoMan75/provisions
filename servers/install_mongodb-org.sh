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

_echo_info 'sudo apt-get install --assume-yes gnupg\n'
sudo apt-get install --assume-yes gnupg

# import the public key used by the package management system.
_echo_info 'wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -\n'
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -

# create a list file for MongoDB
_echo_info "echo 'deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse' | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list\n"
echo 'deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse' | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info 'sudo apt-get install --assume-yes mongodb-org\n'
sudo apt-get install --assume-yes mongodb-org

