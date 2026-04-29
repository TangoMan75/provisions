#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## twingate
##
## VPN client
##
## |        Command        |                     Description                      |
## |-----------------------|------------------------------------------------------|
## | `sudo twingate setup` | Interactively configure the Twingate Client.         |
## | `twingate start`      | Start the Twingate Client.                           |
## | `twingate status`     | Output Twingate Client status.                       |
## | `twingate stop`       | Stop the Twingate Client.                            |
## | `twingate resources`  | Show available Resources for the authenticated user. |
## | `twingate help`       | Show usage information.                              |
##
## @category security
## @link     https://www.twingate.com/docs/linux

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install twingate'

_echo_info 'curl -s https://binaries.twingate.com/client/linux/install.sh | sudo bash\n'
curl -s https://binaries.twingate.com/client/linux/install.sh | sudo bash

