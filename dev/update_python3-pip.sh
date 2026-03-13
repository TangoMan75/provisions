#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## update python3-pip
##
## @category dev

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_echo_info 'python3 -m pip list --outdated --format=freeze | grep -v '^-e' | cut -d= -f1  | xargs -n1 python3 -m pip install -U\n'
python3 -m pip list --outdated --format=freeze | grep -v '^-e' | cut -d= -f1  | xargs -n1 python3 -m pip install -U
