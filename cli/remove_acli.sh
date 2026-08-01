#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove acli
##
## @category cli
## @link     https://developer.atlassian.com/cloud/acli/guides/install-linux/

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_danger "Remove acli"

#--------------------------------------------------

_echo_info 'sudo apt-get remove --assume-yes acli\n'
sudo apt-get remove --assume-yes acli

#--------------------------------------------------

_echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove

#--------------------------------------------------

_echo_info 'sudo rm -f /etc/apt/keyrings/acli-archive-keyring.gpg\n'
sudo rm -f /etc/apt/keyrings/acli-archive-keyring.gpg

_echo_info 'sudo rm -f /etc/apt/sources.list.d/acli.list\n'
sudo rm -f /etc/apt/sources.list.d/acli.list

_echo_info 'sudo apt-get update\n'
sudo apt-get update
