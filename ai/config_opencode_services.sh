#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## config opencode
##
## @category ai
## @link     https://opencode.ai

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_secondary 'Config opencode services'

#--------------------------------------------------

_echo_info "mkdir -p ${HOME}/.config/systemd/user\n"
mkdir -p "${HOME}/.config/systemd/user"

#--------------------------------------------------

cat > "${HOME}/.config/systemd/user/opencode-serve.service" <<- EOF
[Unit]
Description=opencode Serve
After=network-online.target
Wants=network-online.target
StartLimitIntervalSec=0

[Service]
Type=simple
ExecStart=${HOME}/.opencode/bin/opencode serve
Restart=always
RestartSec=5
KillMode=mixed
KillSignal=SIGTERM
TimeoutStopSec=30
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=default.target
EOF

_echo_info 'opencode-serve.service created\n'

#--------------------------------------------------

cat > "${HOME}/.config/systemd/user/opencode-telegram.service" <<- EOF
[Unit]
Description=opencode Telegram Bot
After=network-online.target opencode-serve.service
Requires=opencode-serve.service
BindsTo=opencode-serve.service
PartOf=opencode-serve.service
StartLimitIntervalSec=0

[Service]
Type=simple
ExecStartPre=/bin/sh -c 'for i in \$\$(seq 1 30); do curl -so /dev/null http://127.0.0.1:4096/ 2>/dev/null && exit 0; sleep 2; done; exit 1'
ExecStartPre=/bin/sh -c 'for i in \$\$(seq 1 30); do curl -so /dev/null https://api.telegram.org/ 2>/dev/null && exit 0; sleep 2; done; exit 1'
ExecStart=/usr/bin/opencode-telegram
Restart=always
RestartSec=15
KillMode=mixed
KillSignal=SIGTERM
TimeoutStopSec=30
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=default.target
EOF

_echo_info 'opencode-telegram.service created\n'

#--------------------------------------------------

_echo_info "systemctl --user daemon-reload\n"
systemctl --user daemon-reload

_echo_info 'systemctl --user enable --now opencode-serve.service opencode-telegram.service\n'
systemctl --user enable --now opencode-serve.service opencode-telegram.service
