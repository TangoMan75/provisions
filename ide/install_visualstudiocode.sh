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
# * Visual Studio Code
# * JavaScript IDE
# *
# * @category ide
# * @link     https://code.visualstudio.com/download
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install Visual Studio Code'

if [ ! -x "$(command -v snap)" ]; then
    echo_error "\"$(basename "${0}")\" requires snap to install, try: 'sudo apt-get install -y snapd'"
    exit 1
fi

echo_info 'sudo snap install code --classic'
sudo snap install code --classic

echo_info "$(readlink /snap/code/current)"

# create desktop shortcut
cat > ~/Desktop/code_code.desktop<<EOF
[Desktop Entry]
X-SnapInstanceName=code
Name=Visual Studio Code
Comment=Code Editing. Redefined.
GenericName=Text Editor
Exec=env BAMF_DESKTOP_FILE_HINT=/var/lib/snapd/desktop/applications/code_code.desktop /snap/bin/code --force-user-env --no-sandbox --unity-launch %F
Icon=/snap/code/current/meta/gui/com.visualstudio.code.png
Type=Application
StartupNotify=false
StartupWMClass=Code
Categories=Utility;TextEditor;Development;IDE;
MimeType=text/plain;inode/directory;
Actions=new-empty-window;
Keywords=vscode;

[Desktop Action new-empty-window]
Name=New Empty Window
Exec=env BAMF_DESKTOP_FILE_HINT=/var/lib/snapd/desktop/applications/code_code.desktop /snap/bin/code --force-user-env --no-sandbox --new-window %F
Icon=/snap/code/current/meta/gui/com.visualstudio.code.png
EOF

