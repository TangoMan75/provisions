#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## hermes-agent
##
## The agent that grows with you - Hermes Agent by Nous Research
##
## ```
## hermes
## ```
##
## @category ai
## @link     https://hermes-agent.nousresearch.com
## @link     https://github.com/NousResearch/hermes-agent

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

PROJECT=hermes-agent
AUTHOR=NousResearch
REPOSITORY=${AUTHOR}/${PROJECT}
URL=https://raw.githubusercontent.com/${REPOSITORY}/main/scripts/install.sh

#--------------------------------------------------

_alert_primary "Install ${PROJECT}"

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -fsSL ${URL} | bash\n"
    curl -fsSL "${URL}" | bash

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -qO- ${URL} | bash\n"
    wget -qO- "${URL}" | bash

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi
