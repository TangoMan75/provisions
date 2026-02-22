#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install_homebrew
##
## Installs Homebrew package manager on Linux
##
## ```
## # example usage
## ./install_homebrew.sh
## ```
##
## @category system
## @link     https://docs.brew.sh/Homebrew-on-Linux

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=homebrew

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    _echo_info "/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

elif [ -x "$(command -v wget)" ]; then
    _echo_info "/bin/bash -c \"$(wget -qO- https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"\n"
    /bin/bash -c "$(wget -qO- https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

#--------------------------------------------------

# Add Homebrew to shell rc file
if [ -f ~/.bashrc ]; then
    {
        printf '\n###> homebrew\n';
        printf "eval \"\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)\""
        printf '\n###< homebrew';
    } >> "${HOME}/.bashrc"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Add Homebrew to zsh
if [ -f ~/.zshrc ]; then
    {
        printf '\n###> homebrew\n';
        printf "eval \"\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)\""
        printf '\n###< homebrew';
    } >> "${HOME}/.zshrc"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
fi

#--------------------------------------------------

_echo_warning 'Verify installation\n'

_echo_info 'brew doctor\n'
brew doctor

_echo_info 'brew --version\n'
brew --version

#--------------------------------------------------

_echo_info 'sync\n'
sync
