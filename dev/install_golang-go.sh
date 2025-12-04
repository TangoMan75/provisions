#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## golang-go
##
## @category dev
## @link     https://go.dev

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

alert_primary 'Install golang-go'

echo_info 'sudo apt-get install --assume-yes golang-go\n'
sudo apt-get install --assume-yes golang-go

cat >> ~/.zshrc <<EOF
# Golang environment variables
export GOROOT=/usr/local/go
export GOPATH=\$HOME/go
export PATH=\$GOPATH/bin:\$GOROOT/bin:\$HOME/.local/bin:\$PATH:
EOF
