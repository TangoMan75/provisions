#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## config fix bluetooth idle timeout
##
## @deprecated
## @license    MIT
## @author     "Matthias Morin" <mat@tangoman.io>
## @category   drivers

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_echo_info "sudo sed -i 's/#IdleTimeout=30/IdleTimeout=0/g' /etc/bluetooth/input.conf\n"
sudo sed -i 's/#IdleTimeout=30/IdleTimeout=0/g' /etc/bluetooth/input.conf

