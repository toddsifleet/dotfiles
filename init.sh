#!/bin/bash
dir="$( cd "$( dirname "$0" )" && pwd )"

for file in "$dir"/*
do
  name=~/.$(basename $file)
  if [ ! -f $name ]
  then
    touch $name
  fi
  if grep -Fxq "source $file" $name
  then
    echo "$name already sources $file"
  else
    echo "source $file" >> tmpfile
    cat $name >> tmpfile
    mv tmpfile $name
  fi
done

if [ ! "type brew" > /dev/null ]
then
  echo "Installing Homebrew"
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi

brew update
brew doctor
brew_packages=('zsh' 'git' 'vim' 'tmux' 'python' 'ag' 'readline' 'openssl')
for package in "${brew_packages[@]}"
do
  installed=`brew list $package 2> /dev/null`;
  if [ -z "$installed" ];
  then
    echo "Installing $package"
    brew install $package;
  fi
done

if [ ! -f $dir/.git-prompt.sh ]
then
  curl https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -o $dir/.git-prompt.sh
  echo "source $dir/.git-prompt.sh" >> tmpfile
  cat ~/.bash_profile >> tmpfile
  mv tmpfile ~/.bash_profile
fi


if [ ! -d ~/.vim/bundle/vundle ]
then
  echo "Downloading Vundle"
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi

if [ ! -f ~/.git-completion.bash ]
then
  curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
  echo "source $dir/.git-completion.bash" >> tmpfile
  cat ~/.bash_profile >> tmpfile
fi

source ~/.bash_profile
