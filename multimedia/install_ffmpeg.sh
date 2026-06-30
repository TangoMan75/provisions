#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## ffmpeg
##
## ```
## # Extract audio from video file
## ffmpeg -i input_video.avi -vn -acodec copy output_audio.aac
## ```
## ```
## # Get audio info
## ffprobe -v quiet -print_format json -show_streams -select_streams a input_video.avi
## ```
##
## @category multimedia

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install ffmpeg'

_echo_info 'sudo apt-get install --assume-yes ffmpeg\n'
sudo apt-get install --assume-yes ffmpeg
