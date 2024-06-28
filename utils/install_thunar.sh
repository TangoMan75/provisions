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
# * thunar
# * bulk rename
# *
# * @category utils
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo apt-get install --assume-yes --no-install-recommends thunar'
sudo apt-get install --assume-yes --no-install-recommends thunar

echo_info 'sudo apt-get install --assume-yes thunar-media-tags-plugin'
sudo apt-get install --assume-yes thunar-media-tags-plugin
