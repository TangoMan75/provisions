#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## config_fail2ban
##
## Fail2ban scans log files (e.g. /var/log/apache/error_log) and bans
## IPs that show the malicious signs -- too many password failures,
## seeking for exploits, etc.
##
## @category security
## @link     https://www.fail2ban.org

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

CONFIG_DIR=/etc/fail2ban
JAIL_LOCAL=${CONFIG_DIR}/jail.local
JAIL_D=${CONFIG_DIR}/jail.d

#--------------------------------------------------

_alert_secondary 'Config fail2ban'

#--------------------------------------------------

if [ ! -x "$(command -v fail2ban-client)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires fail2ban, try: 'sudo apt-get install -y fail2ban'\n"
    exit 1
fi

#--------------------------------------------------

while [ -z "${DESTEMAIL}" ]; do
    read -rp "Enter email address for notifications: " DESTEMAIL
done

#--------------------------------------------------

_echo_info "Enter SSH port(s) to protect (comma separated, default: 22)\n"
read -rp "ssh port: [22] " SSH_PORTS
if [ -n "${SSH_PORTS}" ] && [ "${SSH_PORTS}" != 22 ]; then
    SSH_PORTS="22,${SSH_PORTS}"
fi

#--------------------------------------------------

_echo_info "Enter IPs to whitelist (space separated, e.g. 192.168.1.0/24 10.0.0.1)\n"
while [ -z "${WHITELIST_IPS}" ]; do
    read -rp "ip address: " WHITELIST_IPS
done
WHITELIST_IPS="127.0.0.1/8 ::1 ${WHITELIST_IPS}"

#--------------------------------------------------

_echo_info "sudo mkdir -p ${JAIL_D}\n"
sudo mkdir -p "${JAIL_D}"

#--------------------------------------------------

cat << EOF | sudo tee "${JAIL_LOCAL}" > /dev/null
[DEFAULT]
# ──────────────────────────────────────────────
#  Global sensible defaults
# ──────────────────────────────────────────────

# Very important: whitelist your own own IPs / VPN / monitoring
ignoreip    = ${WHITELIST_IPS}

# Use ipset-based actions when possible (much faster)
banaction   = nftables-multiport
banaction_allports = nftables-allports

bantime     = 30m
findtime    = 15m
maxretry    = 4

# ──── Progressive / recidive banning ────────
bantime.increment = true
bantime.factor    = 3
bantime.maxtime   = 4w

# Optional: send email alerts
destemail   = ${DESTEMAIL}
sender      = fail2ban@localhost
action      = %(action_mwl)s

# ──────────────────────────────────────────────
#  Per-service jails – enable only what you use
# ──────────────────────────────────────────────

[sshd]
enabled   = true
port      = ${SSH_PORTS:-22}
filter    = sshd
logpath   = /var/log/auth.log
maxretry  = 3
findtime  = 10m
bantime   = 2h
mode      = aggressive

[recidive]
enabled   = true
bantime   = 4w
findtime  = 365d

EOF

#--------------------------------------------------

_echo_info 'sudo systemctl enable fail2ban\n'
sudo systemctl enable fail2ban

_echo_info 'sudo systemctl restart fail2ban\n'
sudo systemctl restart fail2ban

#--------------------------------------------------

_echo_success "fail2ban configured successfully\n"
