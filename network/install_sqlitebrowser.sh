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
# * sqlitebrowser
# * sqlite client database manager
# *
# * @category network
# * @link     https://sqlitebrowser.org
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install sqlitebrowser'

echo_info 'sudo apt-get install --assume-yes sqlitebrowser'
sudo apt-get install --assume-yes sqlitebrowser

# create desktop shortcut
cat > ~/Desktop/sqlitebrowser.desktop<<EOF
[Desktop Entry]
Name=DB Browser for SQLite
Comment=DB Browser for SQLite is a light GUI editor for SQLite databases
Comment[de]=DB Browser for SQLite ist ein GUI-Editor für SQLite-Datenbanken
Comment[fr]=Un éditeur graphique léger pour les bases de données SQLite
Exec=sqlitebrowser %f
Icon=sqlitebrowser
Terminal=false
X-MultipleArgs=false
Type=Application
Categories=Development;Utility;Database;
MimeType=application/sqlitebrowser;application/x-sqlitebrowser;application/x-sqlite2;application/x-sqlite3;
EOF

