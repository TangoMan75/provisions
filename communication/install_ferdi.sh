#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * Ferdi
# *
# * Ferdi is a destkop app that helps you organize how you use your favourite apps by combining them into one application. It is based on Franz - a software already used by thousands of people - with the difference that Ferdi gives you many additional features and doesn't restrict its usage! Ferdi is compatible with your existing Franz account so you can continue right where you left off. Find out more about Ferdi and its features on getferdi.com.
# *
# * @category communication
# * @link     https://getferdi.com
# * @link     https://github.com/getferdi/ferdi
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

REPOSITORY=getferdi/ferdi
VERSION=$(get_latest_release "${REPOSITORY}")
if [ -z "${VERSION}" ]; then
    VERSION=5.5.0
fi
FILENAME=ferdi_${VERSION}_amd64.deb

alert_primary "Install Ferdi v${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

echo_info "wget -q \"https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${FILENAME}\""
wget -q "https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${FILENAME}"

echo_info "sudo dpkg -i \"${FILENAME}\""
sudo dpkg -i "${FILENAME}"

echo_info "rm -f \"${FILENAME}\""
rm -f "${FILENAME}"

# create desktop shortcut
cat > ~/Desktop/ferdi.desktop<<EOF
[Desktop Entry]
Name=Ferdi
Exec=/opt/Ferdi/ferdi %U
Terminal=false
Type=Application
Icon=ferdi
StartupWMClass=Ferdi
Comment=Ferdi is your messaging app / former Emperor of Austria and combines chat & messaging services into one application. Ferdi currently supports Slack, WhatsApp, WeChat, HipChat, Facebook Messenger, Telegram, Google Hangouts, GroupMe, Skype and many more. You can download Ferdi for free for Mac & Windows.
MimeType=x-scheme-handler/ferdi;
Categories=Network;InstantMessaging;
EOF
