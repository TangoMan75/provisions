#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## config openssh-server
##
## Configure the OpenSSH server for remote access over the LAN and over a
## WireGuard tunnel, then restrict port 22 to those two subnets.
##
## Install the server first:
## ```bash
## ./servers/install_openssh-server.sh
## ```
##
## Apply the configuration:
## ```bash
## ./server/config_openssh-server.sh
## ```
##
## Override the allowed subnets:
## ```bash
## LAN_CIDR=192.168.1.0/24 WIREGUARD_CIDR=192.168.27.64/27 ./server/config_openssh-server.sh
## ```
##
## @category servers
## @link     https://www.openssh.com

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

SSH_PORT=22

CONFIG_DIR=/etc/ssh/sshd_config.d
CONFIG_FILE="${CONFIG_DIR}/00-remote-access.conf"

LAN_CIDR="${LAN_CIDR:-192.168.0.0/24}"
WIREGUARD_CIDR="${WIREGUARD_CIDR:-192.168.27.64/27}"

#--------------------------------------------------

_alert_secondary 'Config sshd'

#--------------------------------------------------

if [ ! -x /usr/sbin/sshd ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires openssh-server, try: './servers/install_openssh-server.sh'\n"
    exit 1
fi

#--------------------------------------------------

_echo_warning 'Write sshd drop-in configuration\n'

_echo_info "sudo mkdir -p \"${CONFIG_DIR}\"\n"
sudo mkdir -p "${CONFIG_DIR}"

_echo_info "sudo tee \"${CONFIG_FILE}\"\n"
sudo tee "${CONFIG_FILE}" > /dev/null <<EOF
# Remote access over LAN and WireGuard.
# Password authentication stays enabled until the phone key is installed.
Port ${SSH_PORT}
PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication yes
KbdInteractiveAuthentication no
ClientAliveInterval 30
ClientAliveCountMax 3
EOF

#--------------------------------------------------

_echo_info 'sudo sshd -t\n'
sudo sshd -t || exit 1

#--------------------------------------------------

_echo_warning 'Enable and restart the ssh service\n'

_echo_info 'sudo systemctl daemon-reload\n'
sudo systemctl daemon-reload

if systemctl list-unit-files ssh.socket 2>/dev/null | grep -q '^ssh.socket'; then
    # Ubuntu 24.04+ listens through ssh.socket
    _echo_info 'sudo systemctl enable --now ssh.socket\n'
    sudo systemctl enable --now ssh.socket

    if systemctl is-active --quiet ssh.service; then
        _echo_info 'sudo systemctl restart ssh.service\n'
        sudo systemctl restart ssh.service
    fi
else
    _echo_info 'sudo systemctl enable --now ssh.service\n'
    sudo systemctl enable --now ssh.service
fi

#--------------------------------------------------

if ! ss -tln | grep -q ":${SSH_PORT} "; then
    _echo_danger "error: sshd is not listening on port ${SSH_PORT}\n"
    exit 1
fi

#--------------------------------------------------

if [ -x "$(command -v ufw)" ]; then
    _echo_warning 'Allow ssh through ufw\n'

    _echo_info "sudo ufw allow from ${LAN_CIDR} to any port ${SSH_PORT} proto tcp comment 'SSH from LAN'\n"
    sudo ufw allow from "${LAN_CIDR}" to any port "${SSH_PORT}" proto tcp comment 'SSH from LAN'

    _echo_info "sudo ufw allow from ${WIREGUARD_CIDR} to any port ${SSH_PORT} proto tcp comment 'SSH from WireGuard'\n"
    sudo ufw allow from "${WIREGUARD_CIDR}" to any port "${SSH_PORT}" proto tcp comment 'SSH from WireGuard'

    _echo_info 'sudo ufw reload\n'
    sudo ufw reload > /dev/null

    if ! sudo ufw status | grep -q 'Status: active'; then
        _echo_warning 'ufw is not active, rules will apply when it is enabled\n'
    fi
else
    _echo_warning 'ufw is not installed, skipping firewall rules\n'
fi

#--------------------------------------------------

_echo_warning 'Host key fingerprints\n'

ssh-keygen -lf /etc/ssh/ssh_host_ed25519_key.pub
ssh-keygen -lf /etc/ssh/ssh_host_rsa_key.pub

#--------------------------------------------------

IP_ADDRESS=$(hostname -I 2>/dev/null | awk '{print $1}')

_echo_success "sshd is listening on port ${SSH_PORT}\n"
if [ -n "${IP_ADDRESS}" ]; then
    _echo_primary "ssh ${USER}@${IP_ADDRESS}\n"
fi
_echo_warning 'Password authentication is enabled until a key is installed, then set "PasswordAuthentication no".\n'
