#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## tightvncserver
## remote desktop server
##
## check server started:
## ```
## ps -edf | grep tightvnc
## ```
## check listenig ports:
## ```
## netstat -lptun | grep vnc
## ```
##
## @category network
## @note     NOT RECOMMENDED: install x11vnc instead

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_echo_info 'sudo apt-get install --assume-yes tightvncserver\n'
sudo apt-get install --assume-yes tightvncserver

# script manager
sudo bash -c 'cat > /usr/local/bin/vncserver <<EOF
#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.
DISPLAY="1"
DEPTH="24"
GEOMETRY="1280x1204"
OPTIONS="-depth \${DEPTH} -geometry \${GEOMETRY} :\${DISPLAY}"

case "\$1" in
    start)
        /usr/bin/tightvncserver \${OPTIONS}
    ;;

    stop)
        /usr/bin/tightvncserver -kill :\${DISPLAY}
    ;;

    restart)
        \$0 stop
        \$0 start
    ;;
    esac
exit 0
EOF'

sudo chmod uga+x /usr/local/bin/vncserver

# systemctl service unit configuration
sudo bash -c "cat > /lib/systemd/system/vncserver.service <<EOF
[Unit]
Description=TigthVNC Service Unit

[Service]
Type=forking
ExecStart=/usr/local/bin/vncserver start
ExecStop=/usr/local/bin/vncserver stop
ExecReload=/usr/local/bin/vncserver restart
User=root

[Install]
WantedBy=multi-user.target
EOF"
