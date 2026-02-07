#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## openclaw
##
## AI-powered CLI tool for chat automation and agent management
##
## @category ai
## @link     https://www.npmjs.com/package/openclaw
## @link     https://openclaw.ai
## @link     https://github.com/openclaw/openclaw
## @link     https://clawhub.ai/skills

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

alert_primary 'Install openclaw'

#--------------------------------------------------

URL=https://openclaw.ai/install.sh

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    echo_info "curl -LsSf \"${URL}\" | bash\n"
    curl -LsSf "${URL}" | bash

elif [ -x "$(command -v wget)" ]; then
    echo_info "wget -qO- \"${URL}\" | bash\n"
    wget -qO- "${URL}" | bash

else
    echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

# workspace directory: .openclaw/workspace

echo_warning 'What to do next:\n'
echo_info '  - setup: '; echo_success 'openclaw setup\n'
echo_info '  - start gateway: '; echo_success 'openclaw gateway strt\n'
echo_info '  - onboard: '; echo_success 'openclaw onboard\n'
echo_info '  - autocompletion: '; echo_success 'openclaw doctor\n'
echo_info '  - start tui: '; echo_success 'openclaw tui\n'
echo_info '  - config browser: '; echo_success 'openclaw browser\n\n'
echo_warning 'openclaw browser --browser-profile openclaw status;\n'
echo_warning 'openclaw browser --browser-profile openclaw start;\n'
echo_warning 'openclaw browser --browser-profile openclaw open https://example.com;\n'
echo_warning 'openclaw browser --browser-profile openclaw snapshot;\n'
