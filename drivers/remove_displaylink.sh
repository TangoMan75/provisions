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
# * @category drivers
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary "Uninstall DisplayLink USB Graphics Software for Ubuntu"

echo_info 'sudo displaylink-installer uninstall'
sudo displaylink-installer uninstall
