#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## yq
##
## command-line yaml/xml processor - jq wrapper for yaml and xml documents
##
## @category dev
## @link     https://yq.readthedocs.io/en/latest
## @link     https://github.com/mikefarah/yq

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v pip3)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires python3-pip, try: 'sudo apt-get install -y python3-pip'\n"
    exit 1
fi

#--------------------------------------------------

PROJECT=yq
AUTHOR=mikefarah
REPOSITORY=${AUTHOR}/${PROJECT}
BINARY=yq_linux_amd64
DESTINATION=/usr/bin/${PROJECT}

#--------------------------------------------------

alert_primary "Install ${PROJECT}"

#--------------------------------------------------

URL=https://github.com/${REPOSITORY}/releases/latest/download/${BINARY}

if [ -x "$(command -v curl)" ]; then
    # download latest version from github with curl
    echo_info "sudo curl -L \"${URL}\" -o \"${DESTINATION}\"\n"
    sudo curl -L "${URL}" -o "${DESTINATION}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    echo_info "sudo wget -nv \"${URL}\" -O \"${DESTINATION}\"\n"
    sudo wget -nv "${URL}" -O "${DESTINATION}"
fi

#--------------------------------------------------

echo_info 'sudo chmod +x /usr/bin/yq\n'
sudo chmod +x /usr/bin/yq

