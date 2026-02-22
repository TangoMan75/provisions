#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
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

_alert_primary "Install ${PROJECT}"

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -LsSf https://opencode.ai/install | bash\n"
    curl -LsSf https://opencode.ai/install | bash

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -qO- https://opencode.ai/install | bash\n"
    wget -qO- https://opencode.ai/install | bash

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi