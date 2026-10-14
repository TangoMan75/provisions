#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## mana toolkit
##
## create fake wifi access point with sniffing and ssl stripping
##
## @category security
## @note     config = /etc/mana-toolkit/hostapd-mana.conf
## @note     start script = /usr/share/mana-toolkit/run-mana/start-nat-simple.sh

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install mana-toolkit'

_echo_info 'apt-get update\n'
apt-get update

_echo_info 'apt-get install --assume-yes build-essential pkg-config git libnl-genl-3-dev libssl-dev\n'
apt-get install --assume-yes build-essential pkg-config git libnl-genl-3-dev libssl-dev

_echo_info 'cd /tmp || exit 1\n'
cd /tmp || exit 1

_echo_info 'git clone https://github.com/sensepost/hostapd-mana\n'
git clone https://github.com/sensepost/hostapd-mana

_echo_info 'cd hostapd-mana || exit 1\n'
cd hostapd-mana || exit 1

_echo_info 'make -C hostapd\n'
make -C hostapd

_echo_info 'mv /tmp/hostapd-mana/hostapd/ /usr/lib/mana-toolkit\n'
mv /tmp/hostapd-mana/hostapd/ /usr/lib/mana-toolkit

_echo_info 'cd /usr/share/ || exit 1\n'
cd /usr/share/ || exit 1

_echo_info 'git clone --depth 1 https://github.com/sensepost/mana.git ./mana-toolkit\n'
git clone --depth 1 https://github.com/sensepost/mana.git ./mana-toolkit

_echo_info 'mkdir -p /etc/mana-toolkit/\n'
mkdir -p /etc/mana-toolkit/

_echo_info 'mv mana-toolkit/run-mana/conf/*.conf /etc/mana-toolkit/\n'
mv mana-toolkit/run-mana/conf/*.conf /etc/mana-toolkit/
