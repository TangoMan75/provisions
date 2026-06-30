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

# install the gpg key
# TODO: Warning: apt-key is deprecated. Manage keyring files in trusted.gpg.d instead (see apt-key(8)).
_echo_info 'wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -\n'
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

# ensure apt is set up to work with https sources:
_echo_info 'sudo apt-get install apt-transport-https\n'
sudo apt-get install apt-transport-https

# stable channel
# sudo add-apt-repository --yes -u 'https://download.sublimetext.com/ apt/stable'
_echo_info 'echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list\n'
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# update apt sources
_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info 'sudo apt-get install --assume-yes apt-transport-https\n'
sudo apt-get install --assume-yes apt-transport-https

_echo_info 'sudo apt-get install --assume-yes sublime-text\n'
sudo apt-get install --assume-yes sublime-text

# create shortcut on desktop
_echo_info "cp -p /usr/share/applications/sublime_text.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/sublime_text.desktop "$(xdg-user-dir DESKTOP)"
