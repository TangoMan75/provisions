#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## fabric
##
## @category ai
## @link     https://github.com/danielmiessler/fabric

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"


# --------------------------------------------------

PROJECT=fabric
AUTHOR=danielmiessler
REPOSITORY=${AUTHOR}/${PROJECT}
REMOTE_FILE=fabric-linux-amd64
BINARY="${PROJECT}"
DESTINATION=/usr/bin/${BINARY}

# --------------------------------------------------

# Download release
URL="https://github.com/${REPOSITORY}/releases/latest/download/${REMOTE_FILE}"

# --------------------------------------------------

alert_primary "Install ${PROJECT}"

# --------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    # download latest version from github with curl
    echo_info "sudo curl -L \"${URL}\" -o \"${DESTINATION}\"\n"
    sudo curl -L "${URL}" -o "${DESTINATION}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    echo_info "sudo wget -nv \"${URL}\" -O \"${DESTINATION}\"\n"
    sudo wget -nv "${URL}" -O "${DESTINATION}"
fi

# --------------------------------------------------

# set executable permissions
echo_info "sudo chmod uga+x \"${DESTINATION}\"\n"
sudo chmod uga+x "${DESTINATION}"

# update system
echo_info 'sync\n'
sync

# --------------------------------------------------

echo_warning 'Run the setup to set up your directories and keys\n'
echo_warning 'fabric --setup\n'

