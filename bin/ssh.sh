#!/bin/bash

source /etc/bash_completion

host=$1
sudo_password=

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
    puts stderr $msg
    exit 1
}

spawn ssh -tt '$host' sudo -i
expect  {
  "password for " {
    send -- "'$pass'\r"
    interact
  } "password:" {
    do_exit "invalid SSH password or account"
  } "try again" {
    do_exit "invalid sudo password"
  } timeout {
    do_exit "timed out waiting for prompt"
  } eof {
    do_exit "connection to host failed: $expect_out(buffer)"
  }
}
')

}

function _ssh() {
  local connect=true
  while [[ "$connect" == true ]]; do

    if [[ -n $sudo_password ]]; then
      _sudo_ssh $host $sudo_password
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
