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
