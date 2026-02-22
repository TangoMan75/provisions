#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install fonts-powerline
##
## @category fonts
## @license  MIT
## @link     https://github.com/powerline/fonts

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# This doesn't work:
# _echo_info 'sudo apt-get install --assume-yes fonts-powerline\n'
# sudo apt-get install --assume-yes fonts-powerline

_echo_info 'mkdir -p ~/.fonts-powerline\n'
mkdir -p ~/.fonts-powerline

_echo_info 'git clone https://github.com/powerline/fonts --depth=1 ~/.fonts-powerline\n'
git clone https://github.com/powerline/fonts --depth=1 ~/.fonts-powerline

_echo_info 'bash  ~/.fonts-powerline/install.sh\n'
bash  ~/.fonts-powerline/install.sh

_echo_info 'rm -rf ~/.fonts-powerline\n'
rm -rf ~/.fonts-powerline

# Fonts are downloaded here:
# .local/share/fonts
