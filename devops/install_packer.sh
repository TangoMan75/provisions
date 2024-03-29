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
# * packer
# *
# * Create identical machine images for multiple platforms from a single source configuration.
# *
# * @category devops
# * @link     https://www.packer.io/downloads
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -'
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

echo_info "sudo apt-add-repository \"deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main\""
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

echo_info 'sudo apt-get install --asssume-yes packer'
sudo apt-get install --asssume-yes packer
