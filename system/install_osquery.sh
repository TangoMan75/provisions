#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## osquery
##
## Multi-platform system information with SQL queries
##
## @category system
## @link     https://osquery.io

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_echo_info 'sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B\n'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B

_echo_info "sudo add-apt-repository 'deb [arch=amd64] https://pkg.osquery.io/deb deb main'\n"
sudo add-apt-repository 'deb [arch=amd64] https://pkg.osquery.io/deb deb main'

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info 'sudo apt install -y osquery\n'
sudo apt install -y osquery

