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
# * mame
# * multiple arcade game emulator
# *
# * @category games
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install mame'

echo_info 'sudo add-apt-repository --yes ppa:c.falco/mame\n'
sudo add-apt-repository --yes ppa:c.falco/mame

echo_info 'sudo apt-get update\n'
sudo apt-get update

echo_info 'sudo apt-get -y install mame\n'
sudo apt-get -y install mame

