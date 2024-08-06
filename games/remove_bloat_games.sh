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
# * remove bloat game
# *
# * @category games
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo apt-get purge --assume-yes aisleriot'
sudo apt-get purge --assume-yes aisleriot

echo_info 'sudo apt-get purge --assume-yes gnome-mahjongg'
sudo apt-get purge --assume-yes gnome-mahjongg

echo_info 'sudo apt-get purge --assume-yes gnome-mines'
sudo apt-get purge --assume-yes gnome-mines

echo_info 'sudo apt-get purge --assume-yes gnome-sudoku'
sudo apt-get purge --assume-yes gnome-sudoku

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

