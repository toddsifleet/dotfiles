# for snap
PATH=$HOME/.cabal/bin:$PATH
PATH=/Users/toddsifleet/Library/Haskell/ghc-7.6.3/lib:$PATH

# for node
export NODE_PATH=/usr/local/lib/node:$NODE_PATH

export PATH=$HOME/Library/Haskell/bin:$PATH

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

function activate() {
	source ~/.virtual_environments/$1/bin/activate
}

function list_virtual_envs() {
	ls ~/.virtual_environments
}

export PATH=/usr/local/bin:$PATH

echo "Reloaded Bash Profile"
