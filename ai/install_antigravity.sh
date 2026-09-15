#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## antigravity
##
## Google Antigravity CLI (agy) - official command-line interface for interacting
## with the Antigravity agent harness. Supports local and remote SSH authentication,
## Gemini API key usage, and headless mode for CI environments.
##
## @category ai
## @link     https://antigravity.google/docs/cli/install/
## @link     https://antigravity.google/docs/cli/overview/

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=antigravity
INSTALL_URL=https://antigravity.google/cli/install.sh

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

_echo_info "curl -fsSL ${INSTALL_URL} | bash\n"
curl -fsSL "${INSTALL_URL}" | bash
