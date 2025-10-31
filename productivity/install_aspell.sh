#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
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

alert_primary 'Install GNU Aspell'

echo_info 'sudo apt-get install --assume-yes aspell aspell-en\n'
sudo apt-get install --assume-yes aspell aspell-en

