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
# * nvidia
# * https://www.nvidia.com/object/unix.html
# *
# * @category drivers
# * @link     https://github.com/stockmind/dell-xps-9560-ubuntu-respin/issues/8#issuecomment-389292575
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# add the nvidia graphic card ppa
echo_info 'sudo add-apt-repository ppa:graphics-drivers'
sudo add-apt-repository ppa:graphics-drivers

echo_info 'sudo apt-get update'
sudo apt-get update

# clean system of previous nvidia drivers
echo_info 'sudo apt-get purge nvidia*'
sudo apt-get purge nvidia*

# echo_info 'sudo apt-get install --assume-yes nvidia-435'
# sudo apt-get install --assume-yes nvidia-435

# echo_info 'sudo apt-get install --assume-yes nvidia-430'
# sudo apt-get install --assume-yes nvidia-430

echo_info 'sudo apt-get install --assume-yes nvidia-390'
sudo apt-get install --assume-yes nvidia-390

# check installation
echo_info 'lsmod | grep nvidia'
lsmod | grep nvidia
