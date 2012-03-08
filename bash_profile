if [ -f ~/.aliases ]; then . ~/.aliases ; fi
if [ -f ~/.secret ]; then . ~/.secret ; fi

export TERM="xterm-256color"
export PATH="/usr/local/Cellar/gettext/0.18.1.1/bin:/usr/local/php/bin:/Users/matt/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
export EDITOR="/usr/local/bin/vim"
export EVENT_NOKQUEUE=1
export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home"
test -r /sw/bin/init.sh && . /sw/bin/init.sh

# Ruby GC settings for REE - https://gist.github.com/865706
export RUBY_HEAP_MIN_SLOTS=600000
export RUBY_HEAP_SLOTS_INCREMENT=10000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1.8
export RUBY_GC_MALLOC_LIMIT=59000000
export RUBY_HEAP_FREE_MIN=100000

function create_puppet_mod {
  mkdir "$1"
  mkdir "$1/files" "$1/lib" "$1/manifests" "$1/templates" "$1/tests"
  touch "$1/manifests/init.pp"
}

function git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function proml {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local       WHITE="\[\033[0;37m\]"
  local   DARK_GRAY="\[\033[1;30m\]"
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac

# use \u@h: for user@host:
PS1="${TITLEBAR}\
\$(rbenv-prompt) $BLUE[$WHITE\u@\h:\w$GREEN\$(git_branch)$BLUE]\
$WHITE\$ "
PS2='> '
PS4='+ '
}
proml
export AUTOFEATURE=true
export RSPEC=true

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
