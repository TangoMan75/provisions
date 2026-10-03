#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## sublime-text
##
## text editor
##
## Find current scope in console:
## ```python
## view.scope_name(view.sel()[0].begin())
## ```
##
## @link     https://gist.github.com/J2TeaM/a54bafb082f90c0f20c9
## @link     https://www.sublimetext.com/docs/scope_naming.html
## @category ide

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install Sublime Text'

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

if [ ! -x "$(command -v gpg)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires gpg, try: 'sudo apt-get install -y gpg'\n"
    exit 1
fi

#--------------------------------------------------

KEYRING_URL=https://download.sublimetext.com/sublimehq-pub.gpg
KEYRING=sublimehq-pub.gpg

#--------------------------------------------------

# ensure apt is set up to work with https sources:
_echo_info 'sudo apt-get install --assume-yes apt-transport-https\n'
sudo apt-get install --assume-yes apt-transport-https

#--------------------------------------------------

_echo_info 'sudo mkdir -p -m 755 /etc/apt/keyrings\n'
sudo mkdir -p -m 755 /etc/apt/keyrings

# install the gpg key in a dedicated keyring (apt-key is gone since Debian 12 / Ubuntu 24.04)
_echo_info "wget -qO- \"${KEYRING_URL}\" | sudo gpg --batch --yes --dearmor -o \"/etc/apt/keyrings/${KEYRING}\"\n"
wget -qO- "${KEYRING_URL}" | sudo gpg --batch --yes --dearmor -o "/etc/apt/keyrings/${KEYRING}"

# stable channel
_echo_info "echo \"deb [signed-by=/etc/apt/keyrings/${KEYRING}] https://download.sublimetext.com/ apt/stable/\" | sudo tee /etc/apt/sources.list.d/sublime-text.list > /dev/null\n"
echo "deb [signed-by=/etc/apt/keyrings/${KEYRING}] https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list > /dev/null

# update apt sources
_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info 'sudo apt-get install --assume-yes sublime-text\n'
sudo apt-get install --assume-yes sublime-text

# create shortcut on desktop
_echo_info "cp -p /usr/share/applications/sublime_text.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/sublime_text.desktop "$(xdg-user-dir DESKTOP)"
