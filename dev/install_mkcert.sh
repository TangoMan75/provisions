#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * mkcert
# * manage locally-trusted development certificates
# *
# * @category dev
# * @link     https://github.com/FiloSottile/mkcert
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

VERSION=1.4.3

alert_primary "Install mkcert v${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

echo_info 'sudo apt-get install --assume-yes libnss3-tools'
sudo apt-get install --assume-yes libnss3-tools

# download binary
# -O,  --output-document=FILE      write documents to FILE
echo_info "wget -qO mkcert https://github.com/FiloSottile/mkcert/releases/download/v${VERSION}/mkcert-v${VERSION}-linux-amd64"
wget -qO mkcert https://github.com/FiloSottile/mkcert/releases/download/v${VERSION}/mkcert-v${VERSION}-linux-amd64

# install globally
echo_info "sudo mv -fv ./mkcert /usr/local/bin/mkcert"
sudo mv -fv ./mkcert /usr/local/bin/mkcert

# set executable permissions
echo_info "sudo chmod uga+x /usr/local/bin/mkcert"
sudo chmod uga+x /usr/local/bin/mkcert

echo_info 'sync'
sync
