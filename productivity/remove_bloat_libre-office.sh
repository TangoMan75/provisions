#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove bloat libre office
##
## @category productivity

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

alert_primary 'Remove Libre Office Bloat'

echo_info 'sudo apt-get purge --assume-yes libreoffice-impress\n'
sudo apt-get purge --assume-yes libreoffice-impress

echo_info 'sudo apt-get purge --assume-yes libreoffice-math\n'
sudo apt-get purge --assume-yes libreoffice-math

echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove

