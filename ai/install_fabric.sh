#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
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

_alert_primary 'Install Fabric'

#--------------------------------------------------

_echo_warning 'Running fabric installer\n'

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -fsSL https://raw.githubusercontent.com/danielmiessler/fabric/main/scripts/installer/install.sh | bash\n"
    curl -fsSL https://raw.githubusercontent.com/danielmiessler/fabric/main/scripts/installer/install.sh | bash

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -qO- https://raw.githubusercontent.com/danielmiessler/fabric/main/scripts/installer/install.sh | bash\n"
    wget -qO- https://raw.githubusercontent.com/danielmiessler/fabric/main/scripts/installer/install.sh | bash

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

#--------------------------------------------------

_echo_warning 'Move fabric binary to /usr/bin\n'
_echo_info 'This will make fabric availlable globally, including scripts\n'

_echo_info "sudo mv \"${HOME}/.local/bin/fabric\" \"/usr/bin\"\n"
sudo mv "${HOME}/.local/bin/fabric" "/usr/bin"

#--------------------------------------------------

_echo_warning 'update system\n'

_echo_info 'sync\n'
sync
