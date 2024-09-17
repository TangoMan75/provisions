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
# * mana toolkit
# *
# * create fake wifi access point with sniffing and ssl stripping
# *
# * @category security
# * @note     config = /etc/mana-toolkit/hostapd-mana.conf
# * @note     start script = /usr/share/mana-toolkit/run-mana/start-nat-simple.sh
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install mana-toolkit'

echo_info 'apt-get update'
apt-get update

echo_info 'apt-get install --assume-yes build-essential pkg-config git libnl-genl-3-dev libssl-dev'
apt-get install --assume-yes build-essential pkg-config git libnl-genl-3-dev libssl-dev

echo_info 'cd /tmp || exit 1'
cd /tmp || exit 1

echo_info 'git clone https://github.com/sensepost/hostapd-mana'
git clone https://github.com/sensepost/hostapd-mana

echo_info 'cd hostapd-mana || exit 1'
cd hostapd-mana || exit 1

echo_info 'make -C hostapd'
make -C hostapd

echo_info 'mv /tmp/hostapd-mana/hostapd/ /usr/lib/mana-toolkit'
mv /tmp/hostapd-mana/hostapd/ /usr/lib/mana-toolkit

echo_info 'cd /usr/share/ || exit 1'
cd /usr/share/ || exit 1

echo_info 'git clone --depth 1 https://github.com/sensepost/mana.git ./mana-toolkit'
git clone --depth 1 https://github.com/sensepost/mana.git ./mana-toolkit

echo_info 'mkdir /etc/mana-toolkit/'
mkdir /etc/mana-toolkit/

echo_info 'mv mana-toolkit/run-mana/conf/*.conf /etc/mana-toolkit/'
mv mana-toolkit/run-mana/conf/*.conf /etc/mana-toolkit/
