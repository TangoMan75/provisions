#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## antigravity
##
## Google Antigravity IDE - AI-powered development platform
##
## @category ide
## @link     https://antigravity.google

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v curl)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary 'Install Antigravity'

#--------------------------------------------------

_echo_warning 'Add Antigravity repository\n'

_echo_info "sudo mkdir -p /etc/apt/keyrings\n"
sudo mkdir -p /etc/apt/keyrings

_echo_info "curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | sudo gpg --dearmor --yes -o /etc/apt/keyrings/antigravity-repo-key.gpg\n"
curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | sudo gpg --dearmor --yes -o /etc/apt/keyrings/antigravity-repo-key.gpg

_echo_info "echo \"deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main\" | sudo tee /etc/apt/sources.list.d/antigravity.list\n"
echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" | sudo tee /etc/apt/sources.list.d/antigravity.list

#--------------------------------------------------

_echo_warning 'Update package cache\n'

_echo_info 'sudo apt-get update\n'
sudo apt-get update

#--------------------------------------------------

_echo_warning 'Install Antigravity\n'

_echo_info 'sudo apt-get install --assume-yes antigravity\n'
sudo apt-get install --assume-yes antigravity

#--------------------------------------------------

# create shortcut on desktop
_echo_info "cp -p \"/usr/share/applications/antigravity.desktop\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/antigravity.desktop" "$(xdg-user-dir DESKTOP)"

