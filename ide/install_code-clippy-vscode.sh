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
# * code-clippy-vscode
# * A free alternative to github copilot
# *
# * @category ide
# * @link     https://github.com/CodedotAl/code-clippy-vscode
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install code-clippy-vscode'

if [ ! -x "$(command -v git)" ]; then
    echo_error "\"$(basename "${0}")\" requires git to install, try: 'sudo apt-get install -y git'"
    exit 1
fi

if [ ! -x "$(command -v node)" ]; then
    echo_error "\"$(basename "${0}")\" requires node to install, try: 'sudo apt-get install -y node'"
    exit 1
fi

if [ ! -x "$(command -v npm)" ]; then
    echo_error "\"$(basename "${0}")\" requires npm to install, try: 'sudo apt-get install -y npm'"
    exit 1
fi

# Fix bug :
# Your cache folder contains root-owned files, due to a bug in
# npm ERR! previous versions of npm which has since been addressed.
echo_info 'sudo chown -R 65534:1000 "/root/.npm"'
sudo chown -R 65534:1000 "/root/.npm"

echo_info 'sudo npm install --global vsce'
sudo npm install --global vsce

echo_info 'git clone https://github.com/CodedotAl/code-clippy-vscode ~/Documents'
git clone https://github.com/CodedotAl/code-clippy-vscode ~/Documents

echo_info 'cd ~/Documents/code-clippy-vscode'
echo_info 'npm install'
echo_info 'npm run esbuild'
echo_info 'vsce package'
echo_info 'code --install-extension code-clippy-0.0.1.vsix'

(
    cd ~/Documents/code-clippy-vscode || exit 1
    npm install
    npm run esbuild
    vsce package
    code --install-extension code-clippy-0.0.1.vsix
)
