#!/bin/sh

#/**
# * TangoMan PHP Serve
# *
# * @licence MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

# colors v6.0.0-min
echo_primary()   { printf '\033[97m%b\033[0m'    "${*}"; }
echo_secondary() { printf '\033[36m%b\033[0m'    "${*}"; }
echo_success()   { printf '\033[32m%b\033[0m'    "${*}"; }
echo_danger()    { printf '\033[31m%b\033[0m'    "${*}"; }
echo_warning()   { printf '\033[33m%b\033[0m'    "${*}"; }
echo_info()      { printf '\033[95m%b\033[0m'    "${*}"; }
echo_light()     { printf '\033[47;90m%b\033[0m' "${*}"; }
echo_dark()      { printf '\033[40;37m%b\033[0m' "${*}"; }

echo_label()     { printf '\033[32m%-*b \033[0m' "$1" "$2"; }
echo_error()     { printf '\033[1;31merror:\t\033[0;91m%s\033[0m' "${*}"; }

alert_primary()   { printf "\033[0m\n\033[1;104;97m%64s\033[0m\n\033[1;104;97m %-63s\033[0m\n\033[1;104;97m%64s\033[0m\n\n" '' "${*}" ''; }
alert_secondary() { printf "\033[0m\n\033[1;45;97m%64s\033[0m\n\033[1;45;97m %-63s\033[0m\n\033[1;45;97m%64s\033[0m\n\n"    '' "${*}" ''; }
alert_success()   { printf "\033[0m\n\033[1;42;37m%64s\033[0m\n\033[1;42;37m %-63s\033[0m\n\033[1;42;37m%64s\033[0m\n\n"    '' "${*}" ''; }
alert_danger()    { printf "\033[0m\n\033[1;41;37m%64s\033[0m\n\033[1;41;37m %-63s\033[0m\n\033[1;41;37m%64s\033[0m\n\n"    '' "${*}" ''; }
alert_warning()   { printf "\033[0m\n\033[1;43;97m%64s\033[0m\n\033[1;43;97m %-63s\033[0m\n\033[1;43;97m%64s\033[0m\n\n"    '' "${*}" ''; }
alert_info()      { printf "\033[0m\n\033[1;44;97m%64s\033[0m\n\033[1;44;97m %-63s\033[0m\n\033[1;44;97m%64s\033[0m\n\n"    '' "${*}" ''; }
alert_light()     { printf "\033[0m\n\033[1;47;90m%64s\033[0m\n\033[1;47;90m %-63s\033[0m\n\033[1;47;90m%64s\033[0m\n\n"    '' "${*}" ''; }
alert_dark()      { printf "\033[0m\n\033[1;40;37m%64s\033[0m\n\033[1;40;37m %-63s\033[0m\n\033[1;40;37m%64s\033[0m\n\n"    '' "${*}" ''; }

clear
alert_primary 'TangoMan PHP Serve'

DOCROOT=.
IP=127.0.0.1
PORT=8888

if [ ! -x "$(command -v php)" ]; then
    echo_error "\"$(basename "${0}")\" requires php, try: 'sudo apt-get install -y php'\n"
    exit 1
fi

nohup xdg-open http://${IP}:${PORT} >/dev/null 2>&1

# run php server command
echo_info "php -d memory-limit=-1 -S ${IP}:${PORT} -t \"${DOCROOT}\"\n"
php -d memory-limit=-1 -S ${IP}:${PORT} -t "${DOCROOT}"
