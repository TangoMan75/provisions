#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * certbot let's encrypt
# *
# * @category security
# * @link     https://certbot.eff.org
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo apt-get install --assume-yes software-properties-common'
sudo apt-get install --assume-yes software-properties-common

echo_info 'sudo add-apt-repository --yes universe'
sudo add-apt-repository --yes universe

echo_info 'sudo add-apt-repository --yes ppa:certbot/certbot'
sudo add-apt-repository --yes ppa:certbot/certbot

echo_info 'sudo apt-get update'
sudo apt-get update

echo_info 'sudo apt-get install --assume-yes certbot python-certbot-nginx '
sudo apt-get install --assume-yes certbot python-certbot-nginx

echo_info 'sudo certbot --nginx'
sudo certbot --nginx

# echo_info 'sudo certbot --nginx certonly'
# sudo certbot --nginx certonly

echo_info 'sudo certbot renew --dry-run'
sudo certbot renew --dry-run
