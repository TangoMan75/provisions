#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Devstral2 Mistral Vibe CLI
##
## @category ai
## @link     https://mistral.ai/fr/news/devstral-2-vibe-cli
## @link     https://console.mistral.ai/codestral/vibe

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install Devstral2 Mistral Vibe CLI'

#--------------------------------------------------

_echo_warning 'Running Devstral2 Mistral Vibe CLI\n'

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -LsSf https://mistral.ai/vibe/install.sh | bash\n"
    curl -LsSf https://mistral.ai/vibe/install.sh | bash

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -qO- https://mistral.ai/vibe/install.sh | bash\n"
    wget -qO- https://mistral.ai/vibe/install.sh | bash

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

#--------------------------------------------------

_echo_warning 'update system\n'

_echo_info 'sync\n'
sync
