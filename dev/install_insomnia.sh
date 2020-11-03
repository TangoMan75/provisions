#!/bin/bash

#/**
# * insomnia
# *
# * API Rest client alternative to postman
# *
# * @category dev
# * @link     https://www.getinsomnia.com
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

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

    # Add to sources
    echo_info "echo 'deb https://dl.bintray.com/getinsomnia/Insomnia /' | sudo tee -a /etc/apt/sources.list.d/insomnia.list"
    echo 'deb https://dl.bintray.com/getinsomnia/Insomnia /' | sudo tee -a /etc/apt/sources.list.d/insomnia.list

    # Add public key used to verify code signature
    echo_info 'wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc | sudo apt-key add -'
    wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc | sudo apt-key add -

    echo_info 'sudo apt-get update'
    sudo apt-get update
fi

echo_info 'sudo apt-get install --assume-yes insomnia'
sudo apt-get install --assume-yes insomnia

# create desktop shortcut
cat > ~/Desktop/insomnia.desktop<<EOF
[Desktop Entry]
Name=Insomnia
Exec=/opt/Insomnia/insomnia %U
Terminal=false
Type=Application
Icon=insomnia
StartupWMClass=Insomnia
Comment=Debug APIs like a human, not a robot
MimeType=x-scheme-handler/insomnia;
Categories=Development;
EOF

