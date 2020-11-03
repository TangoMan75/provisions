#!/bin/bash

#/**
# * chrome
# * web browser
# *
# * @category network
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ "${#}" -gt 1 ]; then
    echo_error "too many arguments (${#})"
    echo_label 'usage'; echo_primary "`basename ${0}` -n (no update) -h (help)"
    exit 1
fi

OPTIND=0
while getopts :nh OPTION; do
    case "${OPTION}" in
        n) UPDATE='false';;
        h) echo_label 'description'; echo_primary "`basename ${0}`"
            echo_label 'usage'; echo_primary "`basename ${0}` -n (no update) -h (help)"
            exit 0;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done

if [ "${UPDATE}" != 'false' ]; then
    if [ `is_installed 'wget'` == 'false' ]; then
        echo_error "\"`basename ${0}`\" requires wget, try: 'sudo apt-get install -y wget'"
        exit 1
    fi

    echo_info 'sudo sh -c echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
    sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'

    echo_info 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -'
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

    echo_info 'sudo apt-get update'
    sudo apt-get update
fi

echo_info 'sudo apt-get install --assume-yes google-chrome-stable'
sudo apt-get install --assume-yes google-chrome-stable

# create desktop shortcut
cat > ~/Desktop/chrome.desktop<<EOF
[Desktop Entry]
Version=1.0
Name=Google Chrome
Comment=Access the Internet
Exec=/usr/bin/google-chrome-stable %U
StartupNotify=true
Terminal=false
Icon=google-chrome
Type=Application
Categories=Network;WebBrowser;
EOF

