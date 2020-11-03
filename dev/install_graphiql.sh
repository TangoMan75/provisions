#!/bin/bash

#/**
# * graphiql
# * A GUI for editing and testing GraphQL queries and mutations
# *
# * @category dev
# * @link     https://electronjs.org/apps/graphiql
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'wget'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

echo_info 'wget -qO graphiql-app-0.7.2-x86_64.AppImage https://github.com/skevy/graphiql-app/releases/download/v0.7.2/graphiql-app-0.7.2-x86_64.AppImage'
wget -qO graphiql-app-0.7.2-x86_64.AppImage https://github.com/skevy/graphiql-app/releases/download/v0.7.2/graphiql-app-0.7.2-x86_64.AppImage

echo_info 'mkdir ~/.graphiql'
mkdir ~/.graphiql

echo_info 'mv -fv graphiql-app-0.7.2-x86_64.AppImage ~/.graphiql'
mv -fv graphiql-app-0.7.2-x86_64.AppImage ~/.graphiql

echo_info 'chmod a+x ~/.graphiql/graphiql-app-0.7.2-x86_64.AppImage'
chmod a+x ~/.graphiql/graphiql-app-0.7.2-x86_64.AppImage

echo_info 'sync'
sync

