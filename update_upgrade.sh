#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## upgrade & dist-upgrade
##
## @license MIT
## @author  "Matthias Morin" <mat@tangoman.io>

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/tools/src/colors/colors.sh"

_alert_secondary 'Upgrade'

# update repositories
_echo_info 'sudo apt-get update\n'
sudo apt-get update

# upgrade packages
_echo_info 'sudo apt-get upgrade -y\n'
sudo apt-get upgrade -y

