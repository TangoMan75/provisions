#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## youtube-dl
##
## NOTE: Install ffmpeg for conversion
##
## ```
## # Download a mp3 file
## youtube-dl --extract-audio --audio-format mp3 --no-playlist https://www.youtube.com/watch?v=1lsnTQyGI78&list=PLArAJlC1y559y95RSJDGaZ2Azra1-Pro6
##
## # Download a playlist
## youtube-dl --extract-audio --audio-format mp3 \
##     --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3753.1 Safari/537.36" \
##     https://www.youtube.com/watch?v=1lsnTQyGI78&list=PLArAJlC1y559y95RSJDGaZ2Azra1-Pro6
##
## # Download thumbnails
## youtube-dl --write-all-thumbnails --skip-download --no-playlist \
##     https://www.youtube.com/watch?v=1lsnTQyGI78&list=PLArAJlC1y559y95RSJDGaZ2Azra1-Pro6
##
## # Download highset resolution thumbnail
## youtube-dl --write-thumbnail --skip-download --no-playlist \
##     https://www.youtube.com/watch?v=1lsnTQyGI78&list=PLArAJlC1y559y95RSJDGaZ2Azra1-Pro6
## ```
##
## @category multimedia
## @link     http://ytdl-org.github.io/youtube-dl/download.html

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=youtube_dl

if [ ! -x "$(command -v pip)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires pip, try: 'sudo apt-get install -y pip'\n"
    exit 1
fi

#--------------------------------------------------

_echo_info "sudo pip install --upgrade-yes \"${APP_NAME}\"\n"
sudo pip install --upgrade-yes "${APP_NAME}"

