#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## yt-dlp
##
## A command-line video downloading program that works by scraping public web pages
## and using undocumented internal APIs (like YouTube's InnerTube)
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

_alert_primary "Install ${PROJECT}"

#--------------------------------------------------

# Download release to directly destination directory
if [ -x "$(command -v curl)" ]; then
    # download latest version from github with curl
    _echo_info "curl -L \"${URL}\" -o \"${DESTINATION}\"\n"
    curl -L "${URL}" -o "${DESTINATION}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    _echo_info "wget -nv \"${URL}\" -O \"${DESTINATION}\"\n"
    wget -nv "${URL}" -O "${DESTINATION}"
fi

#--------------------------------------------------

# set executable permissions
_echo_info "chmod a+rx \"${DESTINATION}\"\n"
chmod a+rx "${DESTINATION}"

#--------------------------------------------------

_echo_warning 'Update system\n'

_echo_info 'sync\n'
sync

