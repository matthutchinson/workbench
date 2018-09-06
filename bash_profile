#!/bin/bash

# use vi for editing mode
# http://www.catonmat.net/blog/bash-vi-editing-mode-cheat-sheet/
set editing-mode vi

# exports
export TERM="screen-256color"
export PATH="~/.cargo/bin:~/go/bin:~/bin:usr/local/php/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
export EDITOR="/usr/local/bin/vim"
export NODE_PATH="/usr/local/lib/node_modules"
export CLICOLOR=1
export XCODE="`xcode-select --print-path`"

# source all the bash things if we have 'em
if [ -d ~/.bash ]; then
  for bash_thing in ~/.bash/*; do
    source $bash_thing
  done
fi

# heroku
export PATH="/usr/local/heroku/bin:$PATH"

# scmpuff
eval "$(scmpuff init -s)"
