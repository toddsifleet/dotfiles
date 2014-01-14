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

if [ -f ~/.bash_profile ]
then
  curl https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -o $dir/.git-prompt.sh
  echo "source $dir/.git-prompt.sh" >> tmpfile
  cat ~/.bash_profile >> tmpfile
  mv tmpfile ~/.bash_profile
fi

source ~/.bash_profile
