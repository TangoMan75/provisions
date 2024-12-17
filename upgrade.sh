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
# * upgrade & dist-upgrade
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")

# shellcheck source=/dev/null
. "${CURDIR}"/tools/src/colors/colors.sh

alert_secondary 'Upgrade'

# upgrade packages
echo_info 'sudo apt-get upgrade -y\n'
sudo apt-get upgrade -y

# # upgrade operating system
# echo_info 'sudo apt-get dist-upgrade -y\n'
# sudo apt-get dist-upgrade -y
