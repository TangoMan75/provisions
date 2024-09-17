#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * k9s
# *
# * @category devops
# * @link     https://github.com/derailed/k9s
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v curl)" ]; then
    echo_error "\"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'"
    exit 1
fi

alert_primary 'Install k9s'

echo_info 'curl -sS https://webinstall.dev/k9s | sh'
curl -sS https://webinstall.dev/k9s | sh

# create symlink into `/usr/bin/``
echo_info 'sudo ln -s ~/.local/bin/k9s /usr/bin/k9s'
sudo ln -s ~/.local/bin/k9s /usr/bin/k9s

echo_info 'sync'
sync
