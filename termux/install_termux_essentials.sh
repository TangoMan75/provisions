#!/bin/bash

## Install termux essentials
install_termux_essentials() {
    _alert_success 'install termux essentials'

    if [ "${OSTYPE}" != 'linux-androideabi' ]; then

        return 1
    fi

    _echo_info 'pkg install -y openssh\n'
    pkg install -y openssh

    _echo_info 'pkg install -y vim\n'
    pkg install -y vim

    _echo_info 'pkg install -y wget\n'
    pkg install -y wget

    _echo_warning 'setup user password'
    _echo_info 'passwd\n'
    passwd
}

install_termux_essentials

