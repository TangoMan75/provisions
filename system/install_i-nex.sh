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
# * i-nex
# *
# * processor information
# *
# * @category system
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo add-apt-repository --yes ppa:i-nex-development-team/daily'
sudo add-apt-repository --yes ppa:i-nex-development-team/daily

echo_info 'sudo add-apt-repository --yes ppa:gambas-team/gambas3'
sudo add-apt-repository --yes ppa:gambas-team/gambas3

echo_info 'sudo apt-get update'
sudo apt-get update

echo_info 'sudo apt install -y i-nex'
sudo apt install -y i-nex
