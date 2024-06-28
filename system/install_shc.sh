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
# * shc
# *
# * Compile `.sh`` scripts to `c` binary
# *
# * ```
# * shc -f foobar.sh -o foobar
# * ```
# *
# * @category system
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install shc'

echo_info 'sudo apt-get install --assume-yes shc'
sudo apt-get install --assume-yes shc

