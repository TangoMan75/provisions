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
    _echo_info "/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)\"\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

elif [ -x "$(command -v wget)" ]; then
    _echo_info "/bin/bash -c \"$(wget -qO- https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)\"\n"
    /bin/bash -c "$(wget -qO- https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

#--------------------------------------------------

_echo_warning 'Configure shell environment\n'

# remove Homebrew from shell rc file
if [ -f ~/.bashrc ]; then
    sed -i '/###> homebrew/,/###< homebrew/d' ~/.bashrc
fi

# remove Homebrew from zsh
if [ -f ~/.zshrc ]; then
    sed -i '/###> homebrew/,/###< homebrew/d' ~/.zshrc
fi
