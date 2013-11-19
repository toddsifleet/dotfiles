#!/bin/bash
dir="$( cd "$( dirname "$0" )" && pwd )"
files=$dir/*

for file in "$dir"/*
do
  name=~/.$(basename $file)
  if [ ! -f $name ]
  then
    touch $name
  fi
  echo "source $file" >> $name
done

if [ -f ~/.bash_profile ]
then
  curl https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -o $dir/.git-prompt.sh
  echo "source $dir/.git-prompt.sh" >> ~/.bash_profile
fi
