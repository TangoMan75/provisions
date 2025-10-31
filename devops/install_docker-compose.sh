#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## docker-compose
##
## @link     https://github.com/docker/compose
## @category devops

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

if [ ! -x "$(command -v curl)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'\n"
    exit 1
fi

REPOSITORY=docker/compose

VERSION=$(get_latest_release ${REPOSITORY})
if [ -z "${VERSION}" ]; then
    VERSION=2.27.1
fi

alert_primary "Install docker-compose v${VERSION}"

# download latest version from github
echo_info "sudo curl -L \"https://github.com/docker/compose/releases/download/v${VERSION}/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/bin/docker-compose\n"
sudo curl -L "https://github.com/docker/compose/releases/download/v${VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose

# set executable permissions
echo_info 'sudo chmod uga+x /usr/bin/docker-compose\n'
sudo chmod uga+x /usr/bin/docker-compose

# create `cli-plugins` folder in `~/.docker` directory
echo_info 'mkdir -p ~/.docker/cli-plugins/\n'
mkdir -p ~/.docker/cli-plugins/

# create binary symlink into `~/.docker/cli-plugins`
echo_info 'ln -s /usr/bin/docker-compose ~/.docker/cli-plugins/docker-compose\n'
ln -s /usr/bin/docker-compose ~/.docker/cli-plugins/docker-compose

# update system
echo_info 'sync\n'
sync

# check command is properly installed
echo_info 'docker compose version\n'
docker compose version

