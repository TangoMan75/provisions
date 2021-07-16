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
# * repair snap
# *
# * @category system
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# if snap showing "snap-confine has elevated permissions and is not confined but should be. Refusing to continue to avoid permission escalation attacks"
# sudo snap refresh core --beta

# remove snap
echo_info 'sudo apt-get remove --assume-yes snapd'
sudo apt-get remove --assume-yes snapd

echo_info 'sudo apt-get purge --assume-yes snapd snap-confine'
sudo apt-get purge --assume-yes snapd snap-confine

# list installed apps
# sudo snap list
