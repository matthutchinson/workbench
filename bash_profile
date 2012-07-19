if [ -f ~/.aliases ]; then . ~/.aliases ; fi
if [ -f ~/.secret ]; then . ~/.secret ; fi

export TERM="xterm-256color"
export PATH="/usr/local/Cellar/gettext/0.18.1.1/bin:/Applications/Firefox 3.app/Contents/MacOS:/usr/local/php/bin:/Users/matt/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
export EDITOR="/usr/local/bin/vim"
export EVENT_NOKQUEUE=1
export NODE_PATH="/usr/local/lib/node_modules"
export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home"
test -r /sw/bin/init.sh && . /sw/bin/init.sh

# Ruby GC settings for REE - https://gist.github.com/865706
export RUBY_HEAP_MIN_SLOTS=600000
export RUBY_HEAP_SLOTS_INCREMENT=10000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1.8
export RUBY_GC_MALLOC_LIMIT=59000000
export RUBY_HEAP_FREE_MIN=100000

function git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

git_commit_time () {
  g=$(git rev-parse --is-inside-work-tree 2>/dev/null) || return
  time=$(git log --format="%cr" -n 1 )
  sed "s/\([0-9]*\) \([ywdhms]\).*/\|\1\2/"<<< "$time"
}

git_color() {
  g=$(git rev-parse --is-inside-work-tree 2>/dev/null) || return
  # Count number of lines in git status (no changes, no lines)
  a="$(git status --short | wc -l)"
  b=0

 # Set the terminal color to orange or green, depending on status (green: no
 # changes, orange: uncomitted changes)
 if (( "$a" > "$b" ))
 then
   tput setaf 94 #orange
 else
   tput setaf 42 #green
 fi
}

function proml {
  local        GRAY="\[\033[0;94m\]"
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local       WHITE="\[\033[0;37m\]"
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
\$(rbenv-prompt) $BLUE[$WHITE\u@\h:\w\$(git_color)\$(git_branch)$GRAY\$(git_commit_time)$BLUE] \
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
