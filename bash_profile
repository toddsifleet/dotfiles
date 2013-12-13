# for snap
PATH=$HOME/.cabal/bin:$PATH
PATH=/Users/toddsifleet/Library/Haskell/ghc-7.6.3/lib:$PATH
export PATH=$HOME/Library/Haskell/bin:$PATH

# for node
export NODE_PATH=/usr/local/lib/node:$NODE_PATH

#brew ruby
export PATH=/usr/local/opt/ruby/bin:$PATH

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

export TERM=xterm-256color

alias staticpy='python ~/Dropbox/github/staticpy/staticpy/main.py'

function new_venv() {
	cd ~/.virtual_environments
	virtualenv $1
	cd - 
}

for d in ~/.virtual_environments/*
do
  if [ -d $d ]; then
    alias activate-$(basename $d)="source $d/bin/activate"
  fi
done

function list_virtual_envs() {
	ls ~/.virtual_environments
}

export PS1='\[$(tput bold)\]\[$(tput setaf 1)\][\t]\[$(tput setaf 2)\]$(__git_ps1 " (%s)") \[$(tput setaf 4)\]\u@\h: \[$(tput setaf 7)\]\w\n$ \[$(tput sgr0)\]'

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

set -o vi
export PATH=/usr/local/bin:$PATH
bind "set completion-ignore-case on"

function line_count() {
  find . -name '*.*' | xargs wc -l
}

function kill_it() {
  kill $(ps aux | grep $1 | awk '{print $2}')
}
export GIT_PS1_SHOWDIRTYSTATE=true
echo "Reloaded Bash Profile"

