#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## tailscale
## Zero-config VPN for building secure networks
##
## @category network
## @link     https://tailscale.com

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=tailscale

#--------------------------------------------------

if [ ! -x "$(command -v curl)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'\n"
    exit 1
fi

#--------------------------------------------------

alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

echo_warning 'Add Tailscale package signing key\n'

echo_info "curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null\n"
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null

#--------------------------------------------------

echo_warning 'Add Tailscale repository\n'

echo_info "curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list\n"
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list >/dev/null

#--------------------------------------------------

echo_info 'sudo apt-get update\n'
sudo apt-get update

#--------------------------------------------------

echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"

#--------------------------------------------------

echo_warning 'Connect to Tailscale network\n'
echo_info 'sudo tailscale up (to authenticate, follow the browser prompt)\n'

#--------------------------------------------------

echo_warning 'update system\n'

echo_info 'sync\n'
sync
