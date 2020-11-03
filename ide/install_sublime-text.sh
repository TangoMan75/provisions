#!/bin/bash

#/**
# * sublime-text
# * text editor
# *
# * @category ide
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
    # sudo add-apt-repository -y -u 'https://download.sublimetext.com/ apt/stable'

    if [ `is_installed 'wget'` == 'false' ]; then
        echo_error "\"`basename ${0}`\" requires wget, try: 'sudo apt-get install -y wget'"
        exit 1
    fi

    # install the gpg key
    echo_info 'wget -q -O - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -'
    wget -q -O - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

    # ensure apt is set up to work with https sources:
    echo_info 'sudo apt-get install apt-transport-https'
    sudo apt-get install apt-transport-https

    # stable channel
    echo_info 'echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list'
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

    # update apt sources
    echo_info 'sudo apt-get update'
    sudo apt-get update
fi

echo_info 'sudo apt-get install --assume-yes apt-transport-https'
sudo apt-get install --assume-yes apt-transport-https

echo_info 'sudo apt-get install --assume-yes sublime-text'
sudo apt-get install --assume-yes sublime-text

# create desktop shortcut
cat > ~/Desktop/sublime_text.desktop<<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Sublime Text
GenericName=Text Editor
Comment=Sophisticated text editor for code, markup and prose
Exec=/opt/sublime_text/sublime_text %F
Terminal=false
Icon=sublime-text
Categories=TextEditor;Development;
StartupNotify=true
EOF
