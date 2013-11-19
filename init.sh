#!/bin/bash

dir=~/dotfiles;

files="bash_profile vimrc tmux.conf"
mkdir -p $backup
for file in $files
do
  if [ ! -f "~/.$file" ]
  then
    touch ~/.$file
  fi
  echo "source ~/dotfiles/$file" >> ~/.$file
done
