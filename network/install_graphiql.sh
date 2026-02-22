#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## graphiql
## A GUI for editing and testing GraphQL queries and mutations
##
## @category network
## @link     https://electronjs.org/apps/graphiql

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

VERSION=$(get_latest_release skevy/graphiql-app)
if [ -z "${VERSION}" ]; then
    VERSION=0.7.2
fi

_alert_primary "Install graphiql v${VERSION}"

_echo_info "wget -qO \"graphiql-app-${VERSION}-x86_64.AppImage\" \"https://github.com/skevy/graphiql-app/releases/download/v${VERSION}/graphiql-app-${VERSION}-x86_64.AppImage\"\n"
wget -qO "graphiql-app-${VERSION}-x86_64.AppImage" "https://github.com/skevy/graphiql-app/releases/download/v${VERSION}/graphiql-app-${VERSION}-x86_64.AppImage"

_echo_info 'mkdir -p ~/.graphiql\n'
mkdir -p ~/.graphiql

_echo_info "mv -fv \"graphiql-app-${VERSION}-x86_64.AppImage\" ~/.graphiql\n"
mv -fv "graphiql-app-${VERSION}-x86_64.AppImage" ~/.graphiql

_echo_info "chmod a+x \"${HOME}/.graphiql/graphiql-app-${VERSION}-x86_64.AppImage\"\n"
chmod a+x "${HOME}/.graphiql/graphiql-app-${VERSION}-x86_64.AppImage"

_echo_info 'sync\n'
sync

