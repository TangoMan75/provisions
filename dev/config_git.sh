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
# * git
# * distributed version control tool
# *
# * @category dev
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_secondary 'Config git'

if [ ! -x "$(command -v git)" ]; then
    echo_error "\"$(basename "${0}")\" requires git, try: 'sudo apt-get install -y git'"
    exit 1
fi

# default push config
echo_info 'git config --global push.default simple'
git config --global push.default simple

# default branch name config
echo_info 'git config --global init.defaultBranch main'
git config --global init.defaultBranch main

# detached HEAD advice
git config --global advice.detachedHead false

# Set git to use the credential memory cache
echo_info 'git config --global credential.helper cache'
git config --global credential.helper cache

# Set the cache to timeout after 1 hour (setting is in seconds)
echo_info "git config --global credential.helper 'cache --timeout=3600'"
git config --global credential.helper 'cache --timeout=3600'

# set vim as git default editor if installed
if [ -x /usr/bin/vim ] ; then
    git config --global core.editor 'vim'
fi
