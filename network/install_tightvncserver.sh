#!/bin/bash

#/**
# * tightvncserver
# * remote desktop server
# *
# * @category network
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

# check server started
# ps -edf | grep tightvnc

# check listenig ports
# netstat -lptun | grep vnc

echo_info 'sudo apt-get install --assume-yes tightvncserver'
sudo apt-get install --assume-yes tightvncserver

# script manager
sudo bash -c 'cat > /usr/local/bin/vncserver <<EOF
#!/bin/bash
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
