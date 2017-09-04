#!/bin/bash

echo "source ~/dotfiles/bash_profile" > ~/.bash_profile
echo "source ~/dotfiles/vimrc" > ~/.vimrc
source ~/.vimrc
source ~/.bash_profile

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -c "BundleInstall" -c 'qa'
