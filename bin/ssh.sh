#!/usr/bin/env bash

host="$1"
uname=$(uname)

# check if we need to use sudo
if [[ "${host:0:1}" == '@' ]]; then
  sudo_password="${SUDO_PASSWORD:-none}"
  host=${host:1} # cut first symbol
fi

function _sudo_ssh() {

  local host=$1
  local pass=$2

  /usr/bin/expect <(echo '

#trap sigwinch and pass it to the child we spawned
trap {
 set rows [stty rows]
 set cols [stty columns]
 stty rows $rows columns $cols < $spawn_out(slave,name)
} WINCH

proc do_exit {msg} {
    send_error "\n\n\[ERROR\] $msg"
    exit 1
}

spawn ssh -tt '$host' sudo -i
expect {
  "Sorry, try again." { do_exit "Invalid SUDO password" }
  "Permission denied, please try again." { do_exit "Invalid SSH password or account" }
  "password:" { send -- "'$pass'\r"; send_user "111"; exp_continue }
  "password for " { send -- "'$pass'\r"; exp_continue }
  "timeout" { do_exit "Timed out waiting for prompt" }
  "#" { interact }
  "$" { interact }
  eof { do_exit "Connection to host failed: $expect_out(buffer)" }
}
')

}

function _ssh() {
  local connect=true
  while [[ "$connect" == true ]]; do

    if [[ -n $sudo_password ]]; then
      _sudo_ssh "$1" "$sudo_password"
    else
      ssh "$1"
    fi

    if [[ "$?" -ne 0 ]]; then
      [[ "$uname" == "Darwin" ]] &&
        osascript -e "display notification \"Connection to $host has been lost\" with title \"SSH\""
      echo
      read -s -r -p "Press any key to reconnect..." -n 1 _
    else
      connect=false
    fi
  done
}

function on_exit() {
  [[ -n $TMUX ]] && tmux set-window-option -t"${TMUX_PANE}" automatic-rename 'on'
  exit
}

host=$(
  command cat <(cat ~/.ssh/config /etc/ssh/ssh_config 2> /dev/null | command grep -i '^host' | command grep -v '*') \
  <(command grep -oE '^[^ ]+' ~/.ssh/known_hosts | tr ',' '\n' | awk '{ print $1 " " $1 }' | sed 's/\[\(\S\+\)\]:[0-9]*/\1/g') \
  <(command grep -v '^\s*\(#\|$\)' /etc/hosts | command grep -Fv '0.0.0.0') |
  awk '{if (length($2) > 0) {print $2}}' | sort -u | fzf -0 -1 -q "$host" || command echo "$host"
)

trap on_exit INT EXIT

_ssh "$host"
