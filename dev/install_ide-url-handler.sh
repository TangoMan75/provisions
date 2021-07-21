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
# * git
# * distributed version control tool
# *
# * @category dev
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install ide-url-handler'

echo_info 'git clone https://github.com/TangoMan75/ide-url-handler'
git clone https://github.com/TangoMan75/ide-url-handler

# echo_info 'wget -q https://raw.githubusercontent.com/TangoMan75/ide-url-handler/master/install.sh'
# wget -q https://raw.githubusercontent.com/TangoMan75/ide-url-handler/master/install.sh

echo_info '(cd ide-url-handler && sudo sh install.sh install)'
(cd ide-url-handler && sudo sh install.sh install)

echo_info 'rm -rf ide-url-handler'
rm -rf ide-url-handler

