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
# * DisplayLink
# *
# * driver for supported DisplayLink USB graphics device
# *
# * @link     https://www.synaptics.com/products/displaylink-graphics/downloads/ubuntu
# * @link     https://www.synaptics.com/sites/default/files/Ubuntu/pool/stable/main/all/synaptics-repository-keyring.deb
# * @category drivers
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

alert_primary "Install DisplayLink USB Graphics Software for Ubuntu"

echo_info "wget \"https://www.synaptics.com/sites/default/files/Ubuntu/pool/stable/main/all/synaptics-repository-keyring.deb\""
wget "https://www.synaptics.com/sites/default/files/Ubuntu/pool/stable/main/all/synaptics-repository-keyring.deb"

echo_info 'sudo apt install ./synaptics-repository-keyring.deb'
sudo apt install ./synaptics-repository-keyring.deb

echo_info 'sudo apt update'
sudo apt update

echo_info 'sudo apt install -y displaylink-driver'
sudo apt install -y displaylink-driver

echo_info 'rm synaptics-repository-keyring.deb'
rm synaptics-repository-keyring.deb

