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
# * mame
# * multiple arcade game emulator
# *
# * @category games
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo add-apt-repository ppa:c.falco/mame'
sudo add-apt-repository ppa:c.falco/mame

echo_info 'sudo apt-get update'
sudo apt-get update

echo_info 'sudo apt-get -y install mame'
sudo apt-get -y install mame
