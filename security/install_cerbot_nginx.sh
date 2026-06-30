#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## certbot let's encrypt
##
## @category security
## @link     https://certbot.eff.org

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install certbot-nginx'

_echo_info 'sudo apt-get install --assume-yes software-properties-common\n'
sudo apt-get install --assume-yes software-properties-common

_echo_info 'sudo add-apt-repository --yes universe\n'
sudo add-apt-repository --yes universe

_echo_info 'sudo add-apt-repository --yes ppa:certbot/certbot\n'
sudo add-apt-repository --yes ppa:certbot/certbot

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info 'sudo apt-get install --assume-yes certbot python-certbot-nginx \n'
sudo apt-get install --assume-yes certbot python-certbot-nginx

_echo_info 'sudo certbot --nginx\n'
sudo certbot --nginx

# _echo_info 'sudo certbot --nginx certonly\n'
# sudo certbot --nginx certonly

_echo_info 'sudo certbot renew --dry-run\n'
sudo certbot renew --dry-run

