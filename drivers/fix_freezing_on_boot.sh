#!/bin/bash

#/**
# * video driver fix freezing on boot (ubuntu 16)
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# * @category drivers
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
echo_info "sudo sed -i -r s/'^GRUB_CMDLINE_LINUX_DEFAULT\s?=\s?\"?\w+\"?$'/'GRUB_CMDLINE_LINUX_DEFAULT=\"quiet\"'/g /etc/default/grub"
sudo sed -i -r s/'^GRUB_CMDLINE_LINUX_DEFAULT\s?=\s?"?\w+"?$'/'GRUB_CMDLINE_LINUX_DEFAULT="quiet"'/g /etc/default/grub

echo_info 'sudo update-grub'
sudo update-grub

