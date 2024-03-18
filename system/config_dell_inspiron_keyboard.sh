#!/bin/sh
set -e

#/*
# * This script is based on TangoMan Shoe Shell Microframework version 0.8.0-xxs
# *
# * This file is distributed under to the MIT license.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * Permission is hereby granted, free of charge, to any person obtaining a copy
# * of this software and associated documentation files (the "Software"), to deal
# * in the Software without restriction, including without limitation the rights
# * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# * copies of the Software, and to permit persons to whom the Software is
# * furnished to do so, subject to the following conditions:
# *
# * The above copyright notice and this permission notice shall be included in all
# * copies or substantial portions of the Software.
# *
# * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# * SOFTWARE.
# *
# * Source code is available here: https://github.com/TangoMan75/shoe
# */

#/**
# * Configure Dell Inspiron keyboard
# *
# * @category system
# * @author  "Matthias Morin" <mat@tangoman.io>
# * @version 0.8.0-xxs
# * @link    https://github.com/TangoMan75/provisions
# * @link    https://help.ubuntu.com/community/Custom%20keyboard%20layout%20definitions
# */

#--------------------------------------------------
# Place your constants after this line
#--------------------------------------------------

## Default
run() {
    insert_xkb_symbols
}

## Open
open() {
    echo_info 'sudo subl /usr/share/X11/xkb/symbols/pc\n'
    sudo subl /usr/share/X11/xkb/symbols/pc
}

## Config by editing xkb symbols
insert_xkb_symbols()
{
    backup_xkb_symbols

    echo_info "sudo sed -i '/.*key <FK11>.*/d' /usr/share/X11/xkb/symbols/pc\n"
    sudo sed -i '/.*key <FK11>.*/d' /usr/share/X11/xkb/symbols/pc

    echo_info "sudo sed -i '/.*key <FK12>.*/d' /usr/share/X11/xkb/symbols/pc\n"
    sudo sed -i '/.*key <FK12>.*/d' /usr/share/X11/xkb/symbols/pc

    echo_info "sudo sed -i '16i\    key <FK12>  {    [ End, End, End, End ]   };' /usr/share/X11/xkb/symbols/pc\n"
    sudo sed -i '16i\    key <FK12>  {    [ End, End, End, End ]   };' /usr/share/X11/xkb/symbols/pc

    echo_info "sudo sed -i '16i\    key <FK11>  {    [ Home, Home, Home, Home ]   };' /usr/share/X11/xkb/symbols/pc\n"
    sudo sed -i '16i\    key <FK11>  {    [ Home, Home, Home, Home ]   };' /usr/share/X11/xkb/symbols/pc

    echo_info "sudo sed -i '/key <HOME>/s/\[.*\]/[ F11, F11, F11, F11 ]/' /usr/share/X11/xkb/symbols/pc\n"
    sudo sed -i '/key <HOME>/s/\[.*\]/[ F11, F11, F11, F11 ]/' /usr/share/X11/xkb/symbols/pc

    echo_info "sudo sed -i '/key  <END>/s/\[.*\]/[ F12, F12, F12, F12 ]/' /usr/share/X11/xkb/symbols/pc\n"
    sudo sed -i '/key  <END>/s/\[.*\]/[ F12, F12, F12, F12 ]/' /usr/share/X11/xkb/symbols/pc

    clear_xkb_cache
}

## Backup xkb symbols
backup_xkb_symbols()
{
    if [ ! -f ./pc.bkp ]; then
        echo_info 'cp -f /usr/share/X11/xkb/symbols/pc ./pc.bkp\n'
        cp -f /usr/share/X11/xkb/symbols/pc ./pc.bkp
    fi
}

## Restore xkb symbols
restore_xkb_symbols()
{
    echo_info 'sudo cp -f ./pc.bkp /usr/share/X11/xkb/symbols/pc\n'
    sudo cp -f ./pc.bkp /usr/share/X11/xkb/symbols/pc

    clear_xkb_cache
}

## Clear xkb cache
clear_xkb_cache()
{
    echo_info 'sudo rm -rf /var/lib/xkb/*\n'
    sudo rm -rf /var/lib/xkb/*

    echo_info 'sudo dpkg-reconfigure xkb-data\n'
    sudo dpkg-reconfigure xkb-data
}

## Config with xmodmap
config_xmodmap() {
    if [ ! -x "$(command -v xmodmap)" ]; then
        echo_error "\"$(basename "${0}")\" requires xmodmap, try: 'sudo apt-get install -y xmodmap'\n"
        return 1
    fi

echo_info 'cat <<EOF | tee ~/.Xmodmap\n'
cat <<EOF | tee ~/.Xmodmap
keycode  95 = Home NoSymbol Home
keycode  96 = End NoSymbol End
keycode 110 = F11 XF86Switch_VT_11 F11
keycode 115 = F12 XF86Switch_VT_12 F12
EOF

    echo_info 'xmodmap ~/.Xmodmap\n'
    xmodmap ~/.Xmodmap

    create_autostart
}

## Create autostart
create_autostart() {
    description='Config Dell Inspire Keyboard'
    name=xmodmap
    command="/usr/bin/xmodmap $HOME/.Xmodmap"

    echo_info 'mkdir -p ~/.config/autostart/\n'
    mkdir -p ~/.config/autostart/

cat <<EOF | tee ~/.config/autostart/$name.desktop
[Desktop Entry]
Name=$name
Comment=$description
Exec=$command
Type=Application
Terminal=true
Hidden=false
EOF
}

## Remove service
remove_service() {
    if [ -z "$1" ]; then
        set -- xmodmap
    fi

    echo_info "systemctl --user stop \"$1.service\"\n"
    systemctl --user stop "$1.service"

    echo_info "systemctl --user disable \"$1.service\"\n"
    systemctl --user disable "$1.service"

    echo_info "sudo rm -f /etc/systemd/system/\"$1.service\"\n"
    sudo rm -f /etc/systemd/system/"$1.service"

    echo_info "sudo rm -f ~/.config/systemd/user/\"$1.service\"\n"
    sudo rm -f ~/.config/systemd/user/"$1.service"
}

## Create service
create_service() {
    # https://doc.ubuntu-fr.org/creer_un_service_avec_systemd
    description='Config Dell Inspire Keyboard'
    name=xmodmap
    command="/usr/bin/xmodmap $HOME/.Xmodmap"

echo_info "cat <<EOF | sudo tee /etc/systemd/system/$name.service\n"
cat <<EOF | sudo tee /etc/systemd/system/$name.service
[Unit]
Description=$description
After=graphical.target

[Service]
ExecStart=$command
Type=oneshot
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

    echo_info "systemctl enable $name.service\n"
    systemctl enable $name.service
}

## Create user service
create_user_service() {
    description='Config Dell Inspire Keyboard'
    name=xmodmap
    command="/usr/bin/xmodmap $HOME/.Xmodmap"

echo_info "cat <<EOF | tee ~/.config/systemd/user/$name.service\n"
cat <<EOF | tee ~/.config/systemd/user/$name.service
[Unit]
Description=$description
After=graphical.target

[Service]
ExecStart=$command
Type=oneshot
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

    echo_info "systemctl --user enable $name.service\n"
    systemctl --user enable $name.service
}

## Show keymap
show_keymap()
{
    if [ ! -x "$(command -v setxkbmap)" ]; then
        echo_error "\"$(basename "${0}")\" requires setxkbmap, try: 'sudo apt-get install -y setxkbmap'"
        return 1
    fi

    echo_info 'setxkbmap -print\n'
    setxkbmap -print
}

## Show keboard events
show_keboard_events()
{
    if [ ! -x "$(command -v xev)" ]; then
        echo_error "\"$(basename "${0}")\" requires xev, try: 'sudo apt-get install -y xev'"
        return 1
    fi

    echo_info 'xev -event keyboard\n'
    xev -event keyboard
}

#--------------------------------------------------
# Semantic colors set
#--------------------------------------------------

# shellcheck disable=SC2034
{
    PRIMARY='\033[97m'; SECONDARY='\033[94m'; SUCCESS='\033[32m'; DANGER='\033[31m'; WARNING='\033[33m'; INFO='\033[95m'; LIGHT='\033[47;90m'; DARK='\033[40;37m'; DEFAULT='\033[0m'; EOL='\033[0m\n';
    ALERT_PRIMARY='\033[1;104;97m'; ALERT_SECONDARY='\033[1;45;97m'; ALERT_SUCCESS='\033[1;42;97m'; ALERT_DANGER='\033[1;41;97m'; ALERT_WARNING='\033[1;43;97m'; ALERT_INFO='\033[1;44;97m'; ALERT_LIGHT='\033[1;47;90m'; ALERT_DARK='\033[1;40;37m';
}

echo_primary()   { printf "%b%b${DEFAULT}" "${PRIMARY}"   "${*}"; }
echo_secondary() { printf "%b%b${DEFAULT}" "${SECONDARY}" "${*}"; }
echo_success()   { printf "%b%b${DEFAULT}" "${SUCCESS}"   "${*}"; }
echo_danger()    { printf "%b%b${DEFAULT}" "${DANGER}"    "${*}"; }
echo_warning()   { printf "%b%b${DEFAULT}" "${WARNING}"   "${*}"; }
echo_info()      { printf "%b%b${DEFAULT}" "${INFO}"      "${*}"; }
echo_light()     { printf "%b%b${DEFAULT}" "${LIGHT}"     "${*}"; }
echo_dark()      { printf "%b%b${DEFAULT}" "${DARK}"      "${*}"; }

echo_label()     { if [ $# -eq 2 ]; then printf "%b%-${1}s ${DEFAULT}" "${SUCCESS}" "$2"; else printf "%b%b ${DEFAULT}" "${SUCCESS}" "${*}"; fi }
echo_error()     { printf "%berror: %b${DEFAULT}" "${DANGER}"  "${*}"; }

alert_primary()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_PRIMARY}"   '' "${ALERT_PRIMARY}"   "${*}" "${ALERT_PRIMARY}"   ''; }
alert_secondary() { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_SECONDARY}" '' "${ALERT_SECONDARY}" "${*}" "${ALERT_SECONDARY}" ''; }
alert_success()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_SUCCESS}"   '' "${ALERT_SUCCESS}"   "${*}" "${ALERT_SUCCESS}"   ''; }
alert_danger()    { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_DANGER}"    '' "${ALERT_DANGER}"    "${*}" "${ALERT_DANGER}"    ''; }
alert_warning()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_WARNING}"   '' "${ALERT_WARNING}"   "${*}" "${ALERT_WARNING}"   ''; }
alert_info()      { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_INFO}"      '' "${ALERT_INFO}"      "${*}" "${ALERT_INFO}"      ''; }
alert_light()     { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_LIGHT}"     '' "${ALERT_LIGHT}"     "${*}" "${ALERT_LIGHT}"     ''; }
alert_dark()      { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_DARK}"      '' "${ALERT_DARK}"      "${*}" "${ALERT_DARK}"      ''; }

#--------------------------------------------------
# Self documentation
#--------------------------------------------------

### Help

## Print this help (default)
help() {
    alert_primary 'TangoMan Shoe XXS'
    echo_warning 'Infos:\n'
    echo_label 10 '  author';  echo_primary '"Matthias Morin" <mat@tangoman.io>\n'
    echo_label 10 '  version'; echo_primary '0.8.0-xxs\n'
    echo_label 10 '  link';    echo_primary 'https://github.com/TangoMan75/shoe\n\n'
    echo_warning 'Description:\n'
    echo_primary '  Create self documented shell scripts with argument validation easily. Prefix a comment with two pound signs on the previous line of any function or variable you want documented with the "help" command.\n\n' | fold -w 64 -s
    echo_warning 'Usage:\n'
    printf "%b  sh $(basename "${0}") [%bcommand%b]\n\n" "${INFO}" "${SUCCESS}" "${INFO}"
    _print_commands 10
}

#--------------------------------------------------

_print_commands() {
    # $1 = padding
    if [ -z "$1" ]; then set -- 12; fi
    printf "%bCommands:%b\n" "${WARNING}" "${DEFAULT}"
    awk "/^### /{printf\"\n${WARNING}%s:${EOL}\",substr(\$0,5)}
        /^(function )? *[a-zA-Z0-9_]+ *\(\) *\{/ {
        sub(\"^function \",\"\"); gsub(\"[ ()]\",\"\");
        FUNCTION = substr(\$0, 1, index(\$0, \"{\"));
        sub(\"{\$\", \"\", FUNCTION);
        if (substr(PREV, 1, 3) == \"## \" && substr(\$0, 1, 1) != \"_\")
        printf \"${SUCCESS}  %-$1s ${DEFAULT}%s\n\", FUNCTION, substr(PREV, 4)
    } { PREV = \$0 }" "$0"
    printf '\n'
}

#--------------------------------------------------
# Core
#--------------------------------------------------

_get_functions() {
    # this regular expression matches functions with either bash or sh syntax
    awk '/^(function )? *[a-zA-Z0-9_]+ *\(\) *\{/ {
        sub("^function ",""); gsub("[ ()]","");   # remove leading "function ", round brackets and extra spaces
        FUNCTION = substr($0, 1, index($0, "{")); # truncate string after opening curly brace
        sub("{$", "", FUNCTION);                  # remove trailing curly brace
        if (substr(PREV, 1, 3) == "## " && substr($0, 1, 1) != "_") print FUNCTION
    } { PREV = $0 }' "$0"
}

#--------------------------------------------------
# Main loop
#--------------------------------------------------

_main() {
    if [ $# -lt 1 ]; then
        help
        exit 0
    fi

    _execute=''
    for _argument in "$@"; do
        _is_valid=false
        for _function in $(_get_functions); do
            # get shorthand character
            _shorthand="$(printf '%s' "${_function}" | awk '{$0=substr($0, 1, 1); print}')"
            if [ "${_argument}" = "${_function}" ] || [ "${_argument}" = "${_shorthand}" ]; then
                # append argument to the execute stack
                _execute="${_execute} ${_function}"
                _is_valid=true
                break
            fi
        done
        # unknown parameters will raise errors
        if [ "${_is_valid}" = false ]; then
            printf "${DANGER}error: \"%s\" is not a valid command${EOL}" "${_argument}"
            exit 1
        fi
    done

    for _function in ${_execute}; do
        eval "${_function}"
    done
}

_main "$@"
