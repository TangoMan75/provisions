#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
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

_alert_danger 'Remove Libre Office Bloat'

_echo_info 'sudo apt-get purge --assume-yes libreoffice-impress\n'
sudo apt-get purge --assume-yes libreoffice-impress

_echo_info 'sudo apt-get purge --assume-yes libreoffice-math\n'
sudo apt-get purge --assume-yes libreoffice-math

_echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove

