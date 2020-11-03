#!/bin/bash

#/**
# * config_keyboard
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

if [ -f '/etc/default/keyboard' ]; then
    echo_info "sudo sed -ie '/^XKBLAYOUT=/s/\".*\"/\"fr\"/' /etc/default/keyboard"
    sudo sed -ie '/^XKBLAYOUT=/s/".*"/"fr"/' /etc/default/keyboard

    # note:  /string1/s/string2/string3/ => replace string1string2 by string1string3
    # TLDR; `s/` doesn't have to be at the beginnig of a string
    echo_info "sudo sed -ie '/^XKBOPTIONS=/s/\".*\"/\"shift:breaks_caps\"/' /etc/default/keyboard"
    sudo sed -ie '/^XKBOPTIONS=/s/".*"/"shift:breaks_caps"/' /etc/default/keyboard
fi

echo_info 'udevadm trigger --subsystem-match=input --action=change'
udevadm trigger --subsystem-match=input --action=change
