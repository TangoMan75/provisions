#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## vlc
##
## multimedia player
##
## Low latency fix - Change the audio output module to ALSA (Advanced Linux Sound Architecture)
##   Tools -> Preferences -> Audio -> Output module -> ALSA audio output
##
## Expand all folders in playlist
##   Tools -> Preferences -> All -> Playlist -> Subdirectory Behavior -> Expand
##
## Allow only one instance
##   Tools -> Preferences -> All -> Playlist -> Allow only one running instance
##
## @category multimedia
## @link     https://www.videolan.org

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=vlc
DESKTOP=${APP_NAME}.desktop

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"

#--------------------------------------------------

# create shortcut on desktop
_echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

