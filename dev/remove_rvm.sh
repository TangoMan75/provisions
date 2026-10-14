#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove rvm
##
## @category dev

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# uninstall rvm
_alert_secondary 'uninstall rvm'

# This will remove the rvm/ directory and all the rubies built within it.
_echo_info 'rvm implode\n'
rvm implode

# In order to remove the final trace of rvm, you need to remove the rvm gem, too:
_echo_info 'gem uninstall rvm\n'
gem uninstall rvm

_echo_info 'rm -rf /etc/rvmrc\n'
rm -rf /etc/rvmrc

_echo_info 'rm -rf ~/.rvmrc\n'
rm -rf ~/.rvmrc

