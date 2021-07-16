#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * vim
# * terminal text editor
# *
# * @category ide
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_secondary 'Config vim'

if [ ! -x "$(command -v vim)" ]; then
    echo_error "\"$(basename "${0}")\" requires vim, try: 'sudo apt-get install -y vim'"
    exit 1
fi

# set vim as git default editor if installed
echo_info "git config --global core.editor 'vim'"
git config --global core.editor 'vim'

