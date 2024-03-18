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
# * lazydocker
# *
# * @link     https://github.com/jesseduffield/lazydocker
# * @category devops
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

if [ ! -x "$(command -v curl)" ]; then
    echo_error "\"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'"
    exit 1
fi

BASENAME=lazydocker
REPOSITORY=jesseduffield/lazydocker

VERSION=$(get_latest_release ${REPOSITORY})
if [ -z "${VERSION}" ]; then
    VERSION=0.23.1
fi

alert_primary "Install ${BASENAME} v${VERSION}"

# download latest version from github
echo_info "curl -L \"https://github.com/${REPOSITORY}/releases/download/v${VERSION}/lazydocker_${VERSION}_$(uname -s)_$(uname -m).tar.gz\" -o \"${BASENAME}.tar.gz\""
curl -L "https://github.com/${REPOSITORY}/releases/download/v${VERSION}/lazydocker_${VERSION}_$(uname -s)_$(uname -m).tar.gz" -o "${BASENAME}.tar.gz"

# extract archive to /usr/bin
echo_info "sudo tar -C /usr/bin -xvzf \"${BASENAME}\".tar.gz \"${BASENAME}\""
sudo tar -C /usr/bin -xvzf ${BASENAME}.tar.gz "${BASENAME}" 

# fix permissions
echo_info "sudo chmod uga+x /usr/bin/${BASENAME}"
sudo chmod uga+x /usr/bin/${BASENAME}

# clean
echo_info "rm -f ${BASENAME}.tar.gz"
rm -f ${BASENAME}.tar.gz

# update system
echo_info 'sync'
sync

