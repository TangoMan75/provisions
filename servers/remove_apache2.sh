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
# * remove apache2
# *
# * @category servers
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo apt-get purge --assume-yes apache2'
sudo apt-get purge --assume-yes apache2

echo_info 'sudo rm -rf /var/lib/apache2'
sudo rm -rf /var/lib/apache2

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

