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
# * remove nodejs
# *
# * @category dev
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# uninstall nodejs
alert_secondary 'uninstall nodejs'

echo_info 'sudo apt-get purge --assume-yes yarn'
sudo apt-get purge --assume-yes yarn

echo_info 'sudo apt-get purge --assume-yes npm'
sudo apt-get purge --assume-yes npm

echo_info 'sudo apt-get purge --assume-yes nodejs'
sudo apt-get purge --assume-yes nodejs

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

