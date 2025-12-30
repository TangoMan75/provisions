#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## mago
## An extremely fast PHP linter, formatter, and static analyzer, written in Rust.
##
## @category dev
## @link     https://github.com/carthage-software/mago

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

alert_primary 'Install mago'

echo_info "curl --proto '=https' --tlsv1.2 -sSf https://carthage.software/mago.sh | bash\n"
curl --proto '=https' --tlsv1.2 -sSf https://carthage.software/mago.sh | bash

echo_info 'sudo mv mago /usr/local/bin/\n'
sudo mv mago /usr/local/bin/

