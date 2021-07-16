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
# * hydra
# *
# * bruteforce password tool
# *
# * @category security
# * @link     https://sectools.org/tool/hydra
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo apt-get install --assume-yes hydra'
sudo apt-get install --assume-yes hydra

echo_info 'sudo apt-get install --assume-yes hydra-gtk'
sudo apt-get install --assume-yes hydra-gtk
