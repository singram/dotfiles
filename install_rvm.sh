#!/bin/bash
source ~/.bashrc
if [[ -z `which rvm` ]]; then
  SCRIPTLOCATION=`dirname "$0"`
  bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )
  cp ~/.bashrc ~/.bashrc_pre_rvm
  cp $SCRIPTLOCATION/bashrc ~/.bashrc
  source ~/.bashrc
  rvm install ree-1.8.7-2010.02
  rvm --default ree-1.8.7-2010.02
  rvm notes
else
  echo 'rvm already installed'
fi