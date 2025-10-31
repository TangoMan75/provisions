#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## fabric
##
## Configuration:
## ```
## ~/.config/fabric
## ```
##
## @category ai
## @link     https://github.com/danielmiessler/fabric

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

alert_primary 'Install Fabric'

#--------------------------------------------------

echo_warning 'Running fabric installer\n'

if [ -x "$(command -v curl)" ]; then
    echo_info "curl -fsSL https://raw.githubusercontent.com/danielmiessler/fabric/main/scripts/installer/install.sh | bash\n"
    curl -fsSL https://raw.githubusercontent.com/danielmiessler/fabric/main/scripts/installer/install.sh | bash

elif [ -x "$(command -v wget)" ]; then
    echo_info "wget -qO- https://raw.githubusercontent.com/danielmiessler/fabric/main/scripts/installer/install.sh | bash\n"
    wget -qO- https://raw.githubusercontent.com/danielmiessler/fabric/main/scripts/installer/install.sh | bash

else
    echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

#--------------------------------------------------

echo_warning 'update system\n'

echo_info 'sync\n'
sync
