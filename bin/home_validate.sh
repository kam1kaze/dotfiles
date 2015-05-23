#!/bin/bash

# core packages
pkgs_centos=(
  bash-completion
  git
  tmux
  pv
  nc
  vcsh
)

# YouCompleteMe requires
pkgs_centos+=( cmake gcc-c++ python-libs python-devel )

declare -a pkgs_install
if fgrep -iq centos /etc/issue; then
  # check packages
  for pkg in ${pkgs_centos[*]}; do
    rpm -q --whatprovides --quiet $pkg || pkgs_install+=( $pkg )
  done
fi



if [[ ${#pkgs_install[*]} -gt 0 ]]; then
  echo "Please do as root:"
  echo "  yum install -y ${pkgs_install[@]}"
  echo "For 'vcsh' use this command:"
  echo "  yum install -y http://dl.fedoraproject.org/pub/fedora/linux/development/rawhide/i386/os/Packages/v/vcsh-1.20141026-1.fc22.noarch.rpm"
  echo "Then execute this script again"
  exit
fi

vcsh clone https://github.com/kam1kaze/dotfiles-main.git

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

include="source ~/.bash_own"
fgrep -q "$include" ~/.bashrc || echo "$include" >> $_
