#!/bin/bash

echo "Install bash dotfiles START"

ln -svr ./bash/bash_aliases ~/.bash_aliases
ln -svr ./bash/bash_functions ~/.bash_functions
ln -svr ./bash/git-prompt.sh ~/.git-prompt.sh
ln -svr ./bash/gitconfig ~/.gitconfig
ln -svr ./bash/inputrc ~/.inputrc

echo "Install bash dotfiles END"