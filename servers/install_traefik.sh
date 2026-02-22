#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## traefik
##
## usage: sudo traefik --accesslog=true --api=true --api.insecure=true --api.dashboard=true --api.debug=true --log.level=INFO
##
## ```
## http://localhost:8080/api/rawdata
## http://localhost:8080/dashboard
## ```
##
## @category servers
## @link     https://doc.traefik.io/traefik/getting-started/quick-start/
## @link     https://raw.githubusercontent.com/containous/traefik/v2.3/traefik.sample.toml

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

REPOSITORY=traefik/traefik
VERSION=2.4.8
FILENAME=traefik_v${VERSION}_linux_amd64.tar.gz

_alert_primary "Install traefik v${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

_echo_info "wget -qO traefik.tar.gz \"https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${FILENAME}\"\n"
wget -qO traefik.tar.gz "https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${FILENAME}"

# extract tar file
_echo_info 'tar xzvf traefik.tar.gz\n'
tar xzvf traefik.tar.gz

# install traefik globally
_echo_info 'sudo mv -fv traefik /usr/local/bin/traefik\n'
sudo mv -fv traefik /usr/local/bin/traefik

# set executable permissions
_echo_info 'sudo chmod uga+x /usr/local/bin/traefik\n'
sudo chmod uga+x /usr/local/bin/traefik

_echo_info 'sync\n'
sync

_echo_info 'rm LICENSE.md CHANGELOG.md traefik.tar.gz\n'
rm LICENSE.md CHANGELOG.md traefik.tar.gz
