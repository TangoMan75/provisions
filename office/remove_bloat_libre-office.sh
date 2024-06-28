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
# * remove bloat libre office
# *
# * @category office
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo apt-get purge --assume-yes libreoffice-draw'
sudo apt-get purge --assume-yes libreoffice-draw

echo_info 'sudo apt-get purge --assume-yes libreoffice-impress'
sudo apt-get purge --assume-yes libreoffice-impress

echo_info 'sudo apt-get purge --assume-yes libreoffice-math'
sudo apt-get purge --assume-yes libreoffice-math

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

