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
# * update repositories
# *
# * /etc/apt/sources.list
# * /etc/apt/sources.list.d
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/tools/src/colors/colors.sh"

alert_secondary 'Update'

# update repositories
echo_info 'sudo apt-get update\n'
sudo apt-get update
