#!/bin/bash

source /etc/bash_completion

host=$1

function _ssh() {
  local connect=true
  while [[ "$connect" == true ]]; do
    ssh $1
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
