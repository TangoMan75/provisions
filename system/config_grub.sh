#!/bin/bash

#/**
# * config grub
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

OPTIND=0
while getopts :h OPTION; do
    case "${OPTION}" in
        h) echo_label 'description'; echo_primary "`basename ${0}`: disable grub splash screen to avoid freeze on boot"
            echo_label 'usage'; echo_primary "`basename ${0}` -h (help)"
            exit 0;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done

# NOTE: sed -r allows to use the `\w` tag in newer linux versions
echo_info "sudo sed -i -r s/'^GRUB_TIMEOUT\s?=\s?\"?\d+\"?$'/'GRUB_TIMEOUT=\"1\"'/g /etc/default/grub"
sudo sed -i -r s/'^GRUB_TIMEOUT\s?=\s?"?\d+"?$'/'GRUB_TIMEOUT="1"'/g /etc/default/grub

# change colors
echo_info "sudo bash -c 'cat > /etc/default/grub <<EOL...EOL"
sudo bash -c 'cat > /etc/default/grub <<EOL
export GRUB_COLOR_NORMAL="light-gray/magenta"
export GRUB_COLOR_HIGHLIGHT="dark-gray/light-magenta"
EOL'

echo_info 'sudo update-grub'
sudo update-grub

