#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * ngnix
# * web server
# *
# * @category servers
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v wget)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

echo_info 'wget http://nginx.org/keys/nginx_signing.key\n'
wget http://nginx.org/keys/nginx_signing.key

echo_info 'sudo apt-key add nginx_signing.key\n'
sudo apt-key add nginx_signing.key

echo_info 'rm -f nginx_signing.key\n'
rm -f nginx_signing.key

# add repository
echo_info "sudo add-apt-repository --yes -u \"deb http://nginx.org/packages/ubuntu/ $(lsb_release -cs) nginx\"\n"
sudo add-apt-repository --yes -u "deb http://nginx.org/packages/ubuntu/ $(lsb_release -cs) nginx"

# update nginx ppa
echo_info 'sudo add-apt-repository --yes ppa:ondrej/nginx\n'
sudo add-apt-repository --yes ppa:ondrej/nginx

echo_info 'sudo apt-get update\n'
sudo apt-get update

echo_info 'sudo apt-get install --assume-yes --allow-unauthenticated nginx\n'
sudo apt-get install --assume-yes --allow-unauthenticated nginx

# # add www-data to nginx group
# echo_info 'sudo usermod -aG www-data nginx\n'
# sudo usermod -aG www-data nginx

# # create basic dev.local
# echo_info 'sudo mv -fv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak\n'
# sudo mv -fv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak

# echo_info 'sudo mv -fv ./config/etc/nginx/dev.local.conf /etc/nginx/dev.local.conf\n'
# sudo mv -fv ./config/etc/nginx/dev.local.conf /etc/nginx/dev.local.conf

# # create /opt/www folder
# echo_info 'sudo mkdir -p /opt/www\n'
# sudo mkdir -p /opt/www

# echo_info 'sudo chown -R www-data:www-data /opt/www\n'
# sudo chown -R www-data:www-data /opt/www

# echo_info 'sudo chmod -R 0775 /opt/www\n'
# sudo chmod -R 0775 /opt/www

# # configure hosts
# echo_info 'sudo echo "127.0.0.1    dev.local">>/etc/hosts\n'
# sudo echo "127.0.0.1    dev.local">>/etc/hosts
