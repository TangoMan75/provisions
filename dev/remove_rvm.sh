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
# * remove rvm
# *
# * @category dev
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# uninstall rvm
alert_secondary 'uninstall rvm'

# This will remove the rvm/ directory and all the rubies built within it.
echo_info 'rvm implode'
rvm implode

# In order to remove the final trace of rvm, you need to remove the rvm gem, too:
echo_info 'gem uninstall rvm'
gem uninstall rvm

echo_info 'rm -rf /etc/rvmrc'
rm -rf /etc/rvmrc

echo_info 'rm -rf ~/.rvmrc'
rm -rf ~/.rvmrc

