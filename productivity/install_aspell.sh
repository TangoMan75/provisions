#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## GNU Aspell
##
## Free and Open Source spell checker
##
## @category productivity
## @link     http://aspell.net

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install GNU Aspell'

_echo_info 'sudo apt-get install --assume-yes aspell aspell-en\n'
sudo apt-get install --assume-yes aspell aspell-en

