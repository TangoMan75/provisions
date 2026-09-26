#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## xtightvncviewer
## remote desktop client
##
## @category network
## @note     NOT RECOMMENDED: install remmina instead
## @note     xtightvncviewer -fullscreen 192.168.0.3:1

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_echo_info 'sudo apt-get install --assume-yes xtightvncviewer\n'
sudo apt-get install --assume-yes xtightvncviewer
