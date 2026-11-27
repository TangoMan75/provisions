#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## aapt
##
## Android Asset Packaging Tool: parses and compiles Android resources
## (AndroidManifest.xml, res/ XML files) into a binary format, generates R.java
## and lets you view, create and update zip/jar/apk archives.
##
## The Debian/Ubuntu package also ships aapt2, the incremental resource
## compiler used by the Android Gradle Plugin (AGP 3.0+).
##
## ```
## # print the tool version
## aapt version
##
## # print an APK manifest details
## aapt dump badging application.apk
## ```
##
## @category android
## @link     https://developer.android.com/tools/aapt2
## @link     https://packages.ubuntu.com/resolute/aapt

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=aapt

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo apt-get update\n"
sudo apt-get update

#--------------------------------------------------

_echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"

#--------------------------------------------------

# aapt and aapt2 are both installed by the aapt package
if [ -x "$(command -v aapt)" ]; then
    _echo_info 'aapt version\n'
    aapt version
fi

if [ -x "$(command -v aapt2)" ]; then
    _echo_info 'aapt2 version\n'
    aapt2 version
fi
