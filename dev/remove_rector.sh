#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove rector
##
## @category dev

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_danger 'Uninstall rector'

#--------------------------------------------------

echo_info 'sudo rm -f /usr/bin/rector\n'
sudo rm -f /usr/bin/rector

echo_info 'composer global remove rector/rector\n'
composer global remove rector/rector

