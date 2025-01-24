#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * apache2
# *
# * web server
# *
# * ```
# * $ sudo systemctl start apache2
# * ```
# *
# * @category servers
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo add-apt-repository --yes ppa:ondrej/apache2\n'
sudo add-apt-repository --yes ppa:ondrej/apache2

echo_info 'sudo apt-get update\n'
sudo apt-get update

echo_info 'sudo apt-get install --assume-yes apache2\n'
sudo apt-get install --assume-yes apache2
