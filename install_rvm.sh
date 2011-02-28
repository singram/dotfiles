#!/bin/bash

if [[ -z `which rvm` ]]; then
  bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )
  cp ~/.bashrc ~/.bashrc_pre_rvm
  SEARCH='[ -z "$PS1" ] && return'
  REPLACE='if [[ -n "$PS1" ]]; then'
  sed -i "s|$SEARCH|$REPLACE|g" ~/.bashrc
  ~/.bashrc <<EOF
 if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi

fi
EOF
  rvm install ree-1.8.7-2010.02
  rvm --default ree-1.8.7-2010.02
  rvm notes
else
  echo 'rvm already installed'
fi