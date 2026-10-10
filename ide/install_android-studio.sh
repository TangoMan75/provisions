#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Android Studio
## Official IDE for Android app development, based on IntelliJ IDEA.
## Includes the Android SDK manager, Gradle build system, emulator, and lint tools.
##
## @category ide
## @link     https://developer.android.com/studio
## @link     https://snapcraft.io/android-studio

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=android-studio
DESKTOP=android-studio_android-studio.desktop

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v snap)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires snap to install, try: 'sudo apt-get install -y snapd'\n"
    exit 1
fi

#--------------------------------------------------

# --classic removes the snap sandbox so the IDE can reach your home directory,
# Android SDK, and USB debugging rules.
_echo_info "sudo snap install \"${APP_NAME}\" --classic\n"
sudo snap install "${APP_NAME}" --classic

#--------------------------------------------------

# create desktop shortcut
_echo_info "ln -s \"/var/lib/snapd/desktop/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
ln -s "/var/lib/snapd/desktop/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"
