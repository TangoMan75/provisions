#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * KeePassXC
# *
# * Password manager
# *
# * @category security
# * @link     https://keepassxc.org
# * @link     https://keepassxc.org/docs/KeePassXC_GettingStarted#_setup_browser_integration
# * @link     https://chrome.google.com/webstore/detail/keepassxc-browser/oboonakemofpalcgghocfoadofidjkkk
# * @link     https://addons.mozilla.org/en-US/firefox/addon/keepassxc-browser
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install KeePassXC'

echo_info 'sudo add-apt-repository --yes ppa:phoerious/keepassxc'
sudo add-apt-repository --yes ppa:phoerious/keepassxc

echo_info 'sudo apt update'
sudo apt update

echo_info 'sudo apt-get install --assume-yes keepassxc'
sudo apt-get install --assume-yes keepassxc

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/org.keepassxc.KeePassXC.desktop \"$(xdg-user-dir DESKTOP)\""
cp -p /usr/share/applications/org.keepassxc.KeePassXC.desktop "$(xdg-user-dir DESKTOP)"

