#!/bin/bash

dir=~/dotfiles;
backup=~/dotfiles_backup;

files="bash_profile vimrc" 
mkdir -p $backup
for file in $files
do
  mv ~/.$file $backup/$file
  ln -s $dir/$file ~/.$file
done
