#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## shellcheck
##
## @category dev
## @link     https://www.shellcheck.net
## @link     https://github.com/koalaman/shellcheck

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install shellcheck'

_echo_info 'sudo apt-get install --assume-yes shellcheck\n'
sudo apt-get install --assume-yes shellcheck
