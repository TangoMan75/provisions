#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Install agnoster Theme
##
## @category themes
## @license  MIT

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# --------------------------------------------------

THEME_NAME=agnoster

alert_primary 'Install agnoster Theme'

# --------------------------------------------------

# check zsh installed
if [ ! -x "$(command -v zsh)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires zsh, try: 'sudo apt-get install -y zsh'\n"
    exit 1
fi

# check oh-my-zsh installed
if [ ! -d ~/.oh-my-zsh ]; then
    echo_danger 'error: oh-my-zsh not installed'
    exit 1
fi

# check .zshrc present
if [ ! -f ~/.zshrc ]; then
    echo_danger 'error: .zshrc file not found'
    exit 1
fi

# --------------------------------------------------

echo_info "sed -i -E s/ZSH_THEME=\".+\"/ZSH_THEME=\"${THEME_NAME}\"/g ~/.zshrc\n"
sed -i -E s/ZSH_THEME=\".+\"/ZSH_THEME=\"${THEME_NAME}\"/g ~/.zshrc

# --------------------------------------------------

echo_success "${THEME_NAME} theme set successfully"
echo_info 'You may need to restart your session\n'

