#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## yt-dlp
##
## @category multimedia
## @link     https://github.com/yt-dlp/yt-dlp

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

PROJECT=yt-dlp
AUTHOR=yt-dlp
REPOSITORY=${AUTHOR}/${PROJECT}
REMOTE_FILE=yt-dlp
DESTINATION="${HOME}/.local/bin/${REMOTE_FILE}"
URL="https://github.com/${REPOSITORY}/releases/latest/download/${REMOTE_FILE}"

#--------------------------------------------------

alert_primary "Install ${PROJECT}"

#--------------------------------------------------

# Download release to directly destination directory
if [ -x "$(command -v curl)" ]; then
    # download latest version from github with curl
    echo_info "curl -L \"${URL}\" -o \"${DESTINATION}\"\n"
    curl -L "${URL}" -o "${DESTINATION}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    echo_info "wget -nv \"${URL}\" -O \"${DESTINATION}\"\n"
    wget -nv "${URL}" -O "${DESTINATION}"
fi

#--------------------------------------------------

# set executable permissions
echo_info "chmod a+rx \"${DESTINATION}\"\n"
chmod a+rx "${DESTINATION}"

#--------------------------------------------------

echo_warning 'Update system\n'

echo_info 'sync\n'
sync

