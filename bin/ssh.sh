#!/bin/bash

if [[ -f /etc/bash_completion ]]; then
  source /etc/bash_completion
elif [[ -f /usr/local/etc/bash_completion ]]; then
  source /usr/local/etc/bash_completion
fi

[[ -f $HOME/.bash_own ]] && source $HOME/.bash_own

host=$1
sudo_password=""

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
  "#" { interact; exp_continue }
  "$" { interact; exp_continue }
  eof { do_exit "Connection to host failed: $expect_out(buffer)" }
}
')

}

function _ssh() {
  local connect=true
  while [[ "$connect" == true ]]; do

    if [[ -n $sudo_password ]]; then
      _sudo_ssh $1 $sudo_password
    else
      ssh $1
    fi

    if [[ "$?" -ne 0 ]]; then
      local dumm
      echo
      read -s -r -p "Press any key to reconnect..." -n 1 dummy
    else
      connect=false
    fi
  done
}

_known_hosts_real -a -F '' $host

# we need only uniq hosts
COMPREPLY=( $(echo "${COMPREPLY[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ') )

total=${#COMPREPLY[*]}

case $total in
  0)
    _ssh $host
    ;;
  1)
    _ssh ${COMPREPLY[0]}
    ;;
  *)
    for (( i=0; i<=$(( $total -1 )); i++ )); do
      echo "$(( i+1 )). ${COMPREPLY[$i]}"
    done

    num=1000
    while [[ $(( $total/$num )) == 0 ]]; do
      read -r num
    done
    _ssh ${COMPREPLY[$((num-1))]}
    ;;
esac
