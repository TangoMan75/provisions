#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## opencode
##
## ```
## s ~/.local/share/opencode
## ```
##
## @category ai
## @link     https://github.com/sst/opencode
## @link     https://opencode.ai

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

PROJECT=opencode

#--------------------------------------------------

alert_primary "Install ${PROJECT}"

#--------------------------------------------------

echo_info 'curl -sSL https://opencode.ai/install | bash\n'
curl -sSL https://opencode.ai/install | bash

