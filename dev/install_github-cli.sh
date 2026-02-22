#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Github CLI
##
## gh --help
##
## @category dev
## @link     https://github.com/cli/cli/

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

#--------------------------------------------------

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

#--------------------------------------------------

VERSION=$(get_latest_release cli/cli)
if [ -z "${VERSION}" ]; then
    VERSION=2.24.3
fi

#--------------------------------------------------

_alert_primary "Install git-cli v${VERSION}"

#--------------------------------------------------

# download archive
_echo_info "wget \"https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_amd64.tar.gz\"\n"
wget "https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_amd64.tar.gz"

#--------------------------------------------------

# extract archive
_echo_info "tar xvzf \"gh_${VERSION}_linux_amd64.tar.gz\"\n"
tar xvzf "gh_${VERSION}_linux_amd64.tar.gz"

#--------------------------------------------------

# install globally
_echo_info "sudo mv -fv \"./gh_${VERSION}_linux_amd64/bin/gh\" /usr/local/bin/gh\n"
sudo mv -fv "./gh_${VERSION}_linux_amd64/bin/gh" /usr/local/bin/gh

#--------------------------------------------------

# set executable permissions
_echo_info "sudo chmod uga+x /usr/local/bin/gh\n"
sudo chmod uga+x /usr/local/bin/gh

#--------------------------------------------------

# clean
_echo_info "rm -rf \"gh_${VERSION}_linux_amd64\"\n"
rm -rf "gh_${VERSION}_linux_amd64"

_echo_info "rm -f \"gh_${VERSION}_linux_amd64.tar.gz\"\n"
rm -f "gh_${VERSION}_linux_amd64.tar.gz"

#--------------------------------------------------

_echo_info 'sync\n'
sync

#--------------------------------------------------

# remove pager
_echo_info 'gh config set pager cat\n'
gh config set pager cat

_echo_info 'gh config set editor vim\n'
gh config set editor vim

