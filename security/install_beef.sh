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
# * beef
# *
# * browser exploitation framework
# *
# * @category security
# * @link     https://beefproject.com
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install beef'

if [ ! -x "$(command -v git)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires git, try: 'apt-get install -y git'\n"
    exit 1
fi

if [ ! -x "$(command -v ruby)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires ruby, try: 'apt-get install -y ruby'\n"
    exit 1
fi

# clone project
echo_info 'git clone --depth 1 https://github.com/beefproject/beef ~/.beef\n'
git clone --depth 1 https://github.com/beefproject/beef ~/.beef

# Install requirements from within the .beef folder
(
    echo_info 'cd ~/.beef || exit 1\n'
    cd ~/.beef || exit 1

    # cleaning git cache
    echo_info 'rm -rf .git\n'
    rm -rf .git

    # install gems
    if [ -w Gemfile.lock ]; then
        rm -f Gemfile.lock
    fi

    echo_info 'sudo ./install\n'
    sudo ./install

    # change credentials
    echo_info "sed -i -E '/^\s{8}user/ s/:\s*\"\w+\"/: \"root\"/' ./config.yaml\n"
    sed -i -E '/^\s{8}user/ s/:\s*"\w+"/: "root"/' ./config.yaml

    echo_info "sed -i -E '/^\s{8}passwd/ s/:\s*\"\w+\"/: \"toor\"/' ./config.yaml\n"
    sed -i -E '/^\s{8}passwd/ s/:\s*"\w+"/: "toor"/' ./config.yaml

    # use port 80
    echo_info "sed -i -E '/^\s{8}port/ s/:\s*\"[0-9]+\"/: \"80\"/' ./config.yaml\n"
    sed -i -E '/^\s{8}port/ s/:\s*"[0-9]+"/: "80"/' ./config.yaml
)
