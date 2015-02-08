#!/bin/bash -l

source /etc/bash_completion

host=$1

_known_hosts_real -a -F '' $host

#set -x

# we need only uniq hosts
COMPREPLY=( $(echo "${COMPREPLY[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ') )

total=${#COMPREPLY[*]}

case $total in
  0)
    ssh $host
    ;;
  1)
    ssh ${COMPREPLY[0]}
    ;;
  *)
    for (( i=0; i<=$(( $total -1 )); i++ )); do
      echo "$(( i+1 )). ${COMPREPLY[$i]}"
    done

    num=1000
    while [[ $(( $total/$num )) == 0 ]]; do
      read -r num
    done
    ssh ${COMPREPLY[$((num-1))]}
    ;;
esac
