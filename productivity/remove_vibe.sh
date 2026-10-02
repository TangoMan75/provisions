#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove vibe
##
## Experience seamless language transcription with Vibe - your all-in-one solution for effortless audio and video transcription.
##
## @category productivity
## @link     https://thewh1teagle.github.io/vibe
## @link     https://github.com/thewh1teagle/vibe

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=vibe
DESKTOP="${APP_NAME}.desktop"

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(dpkg)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

_echo_info "sudo dpkg --purge \"${APP_NAME}\"\n"
sudo dpkg --purge "${APP_NAME}"

#--------------------------------------------------

# remove configuration and data directories
_echo_info "rm -rf \"${HOME}/.config/github.com.thewh1teagle.vibe\"\n"
rm -rf "${HOME}/.config/github.com.thewh1teagle.vibe"

_echo_info "rm -rf \"${HOME}/.local/share/github.com.thewh1teagle.vibe\"\n"
rm -rf "${HOME}/.local/share/github.com.thewh1teagle.vibe"

#--------------------------------------------------

# remove desktop shortcut
_echo_info "rm \"$(xdg-user-dir DESKTOP)/${DESKTOP}\"\n"
rm "$(xdg-user-dir DESKTOP)/${DESKTOP}"
