#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## net-tools
##
## A collection of programs that form the base set of the NET-3 networking distribution for the Linux operating system.
##
## Includes: arp ifconfig ipmaddr iptunnel mii nameif plipconfig rarp route and slattach
##
## @category network
## @link     https://sourceforge.net/projects/net-tools

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=net-tools

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"
_echo_warning 'Includes: arp ifconfig ipmaddr iptunnel mii nameif plipconfig rarp route and slattach\n'

#--------------------------------------------------

_echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"

