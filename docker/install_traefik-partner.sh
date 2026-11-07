#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## traefik-partner
##
## TangoMan Traefik Partner: Streamline Your Traefik Setup with Docker.
##
## ```
## # Run traefik setup
## traefik up
## ```
##
## @category docker
## @link     https://github.com/TangoMan75/traefik-partner

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -fsSL https://raw.githubusercontent.com/TangoMan75/traefik-partner/main/install.sh | sh\n"
    curl -fsSL https://raw.githubusercontent.com/TangoMan75/traefik-partner/main/install.sh | sh

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -qO- https://raw.githubusercontent.com/TangoMan75/traefik-partner/main/install.sh | sh\n"
    wget -qO- https://raw.githubusercontent.com/TangoMan75/traefik-partner/main/install.sh | sh

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi
