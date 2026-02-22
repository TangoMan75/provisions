#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## symfony cli
##
## @category dev
## @link     https://symfony.com/doc/current/setup.html

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install Symfony CLI'

#--------------------------------------------------

if [ ! -x "$(command -v curl)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'\n"
    exit 1
fi

#--------------------------------------------------

# -s, --silent        Silent mode
# -S, --show-error    Show error even when -s is used
_echo_info 'sudo curl -sS https://get.symfony.com/cli/installer | bash\n'
sudo curl -sS https://get.symfony.com/cli/installer | bash

#--------------------------------------------------

# install symfony installer globally
_echo_info 'sudo mv -fv ~/.symfony5/bin/symfony /usr/local/bin/symfony\n'
sudo mv -fv ~/.symfony5/bin/symfony /usr/local/bin/symfony

#--------------------------------------------------

_echo_info 'sync\n'
sync

