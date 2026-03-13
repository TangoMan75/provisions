#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install_zeroclaw
##
## Install ZeroClaw - Fast, small, autonomous AI assistant infrastructure
##
## ```
## # config can be found here
## ~/.zeroclaw
##
## # biniary can be found here
## ~/.cargo/bin/zeroclaw
##
## # start onboarding
## zeroclaw onboard --interactive
## ```
##
## @category ai
## @link     https://github.com/zeroclaw-labs/zeroclaw
## @link     https://zeroclawlabs.ai

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install ZeroClaw'

#--------------------------------------------------

URL=https://raw.githubusercontent.com/zeroclaw-labs/zeroclaw/refs/heads/master/install.sh

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -sSLf \"${URL}\" | bash\n"
    curl -sSLf "${URL}" | bash

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -qO- \"${URL}\" | bash\n"
    wget -qO- "${URL}" | bash

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi
