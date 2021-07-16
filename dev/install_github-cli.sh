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
# * Github CLI
# *
# * @category dev
# * @link     https://github.com/cli/cli/
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

VERSION=$(get_latest_release cli/cli)
if [ -z "${VERSION}" ]; then
    VERSION=1.9.2
fi

alert_primary "Install git-cli v${VERSION}"

# download archive
echo_info "wget https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_amd64.tar.gz"
wget https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_amd64.tar.gz

# extract archive
echo_info "tar xvzf gh_${VERSION}_linux_amd64.tar.gz"
tar xvzf gh_${VERSION}_linux_amd64.tar.gz

# install globally
echo_info "sudo mv -fv ./gh_${VERSION}_linux_amd64/bin/gh /usr/local/bin/gh"
sudo mv -fv ./gh_${VERSION}_linux_amd64/bin/gh /usr/local/bin/gh

# fix permissions
echo_info "sudo chmod uga+x /usr/local/bin/gh"
sudo chmod uga+x /usr/local/bin/gh

# clean
echo_info "rm -rf gh_${VERSION}_linux_amd64"
rm -rf gh_${VERSION}_linux_amd64

echo_info "rm -f gh_${VERSION}_linux_amd64.tar.gz"
rm -f gh_${VERSION}_linux_amd64.tar.gz

echo_info 'sync'
sync
