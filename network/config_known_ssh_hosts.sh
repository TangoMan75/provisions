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
# * config known ssh hosts
# *
# * @category network
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_secondary 'Config known ssh hosts'

# create ~/.ssh/known_hosts if not exists
echo_info 'touch ~/.ssh/known_hosts'
touch ~/.ssh/known_hosts

# add github.com, gitlab.com and bitbucket.org keys to known_hosts
echo_info 'ssh-keyscan -H github.com >> ~/.ssh/known_hosts'
ssh-keyscan -H github.com >> ~/.ssh/known_hosts

echo_info 'ssh-keyscan -H gist.github.com >> ~/.ssh/known_hosts'
ssh-keyscan -H gist.github.com >> ~/.ssh/known_hosts

echo_info 'ssh-keyscan -H bitbucket.org >> ~/.ssh/known_hosts'
ssh-keyscan -H bitbucket.org >> ~/.ssh/known_hosts

echo_info 'ssh-keyscan -H gitlab.com >> ~/.ssh/known_hosts'
ssh-keyscan -H gitlab.com >> ~/.ssh/known_hosts

echo_info 'chmod 644 ~/.ssh/known_hosts'
chmod 644 ~/.ssh/known_hosts

echo_info "chown \"${USER}:${USER}\" ~/.ssh/known_hosts"
chown "${USER}:${USER}" ~/.ssh/known_hosts
