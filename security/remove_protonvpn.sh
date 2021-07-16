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
# * protonvpn
# *
# * @category security
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# disable kill switch
echo_info 'protonvpn-cli ks --off'
protonvpn-cli ks --off

# uninstall app
echo_info 'sudo apt-get autoremove protonvpn'
sudo apt-get autoremove protonvpn

# clear cache
echo_info 'rm -rf ~/.cache/protonvpn'
rm -rf ~/.cache/protonvpn

# remove config files
echo_info 'rm -rf ~/.config/protonvpn'
rm -rf ~/.config/protonvpn

echo_info "sudo add-apt-repository --remove --yes 'deb https://repo.protonvpn.com/debian unstable main'"
sudo add-apt-repository --remove --yes 'deb https://repo.protonvpn.com/debian unstable main'
