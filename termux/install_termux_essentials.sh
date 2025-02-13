#!/bin/bash

## Install termux essentials
install_termux_essentials() {
    alert_success 'install termux essentials'

    if [ "${OSTYPE}" != 'linux-androideabi' ]; then

        return 1
    fi

    echo_info 'pkg install -y openssh\n'
    pkg install -y openssh

    echo_info 'pkg install -y vim\n'
    pkg install -y vim

    echo_info 'pkg install -y wget\n'
    pkg install -y wget

    echo_warning 'setup user password'
    echo_info 'passwd\n'
    passwd
}

install_termux_essentials

