#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * remove ohmyzsh
# *
# * @category themes
# * @license  MIT
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# clean zsh folder
echo_info 'rm -rf ~/.oh-my-zsh\n'
rm -rf ~/.oh-my-zsh

echo_info 'rm -f ~/.zshrc\n'
rm -f ~/.zshrc

echo_info 'rm -f ~/.zshrc.bak\n'
rm -f ~/.zshrc.bak

echo_info 'rm -f ~/.zsh_history\n'
rm -f ~/.zsh_history

echo_success 'oh-my-zsh uninstalled\n'
