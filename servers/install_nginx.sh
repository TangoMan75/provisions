#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## ngnix
## web server
##
## @category servers

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

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

KEYRING_URL=http://nginx.org/keys/nginx_signing.key
KEYRING=nginx_signing.gpg

#--------------------------------------------------

# install the gpg key in a dedicated keyring (apt-key is gone since Debian 12 / Ubuntu 24.04)
_echo_info 'sudo mkdir -p -m 755 /etc/apt/keyrings\n'
sudo mkdir -p -m 755 /etc/apt/keyrings

_echo_info "wget -qO- \"${KEYRING_URL}\" | sudo gpg --batch --yes --dearmor -o \"/etc/apt/keyrings/${KEYRING}\"\n"
wget -qO- "${KEYRING_URL}" | sudo gpg --batch --yes --dearmor -o "/etc/apt/keyrings/${KEYRING}"

# add repository
_echo_info "echo \"deb [signed-by=/etc/apt/keyrings/${KEYRING}] http://nginx.org/packages/ubuntu/ $(lsb_release -cs) nginx\" | sudo tee /etc/apt/sources.list.d/nginx.list > /dev/null\n"
echo "deb [signed-by=/etc/apt/keyrings/${KEYRING}] http://nginx.org/packages/ubuntu/ $(lsb_release -cs) nginx" | sudo tee /etc/apt/sources.list.d/nginx.list > /dev/null

# update nginx ppa
_echo_info 'sudo add-apt-repository --yes ppa:ondrej/nginx\n'
sudo add-apt-repository --yes ppa:ondrej/nginx

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info 'sudo apt-get install --assume-yes nginx\n'
sudo apt-get install --assume-yes nginx

# # add www-data to nginx group
# _echo_info 'sudo usermod -aG www-data nginx\n'
# sudo usermod -aG www-data nginx

# # create basic dev.local
# _echo_info 'sudo mv -fv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak\n'
# sudo mv -fv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak

# _echo_info 'sudo mv -fv ./config/etc/nginx/dev.local.conf /etc/nginx/dev.local.conf\n'
# sudo mv -fv ./config/etc/nginx/dev.local.conf /etc/nginx/dev.local.conf

# # create /opt/www folder
# _echo_info 'sudo mkdir -p /opt/www\n'
# sudo mkdir -p /opt/www

# _echo_info 'sudo chown -R www-data:www-data /opt/www\n'
# sudo chown -R www-data:www-data /opt/www

# _echo_info 'sudo chmod -R 0775 /opt/www\n'
# sudo chmod -R 0775 /opt/www

# # configure hosts
# _echo_info 'sudo echo "127.0.0.1    dev.local">>/etc/hosts\n'
# sudo echo "127.0.0.1    dev.local">>/etc/hosts
