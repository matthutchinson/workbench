# some imports
if [ -f ~/.aliases ]; then . ~/.aliases ; fi
if [ -f ~/.secret ]; then . ~/.secret ; fi

# some exports
export TERM="xterm-256color"
export AUTOFEATURE=true
export RSPEC=true
export PATH="/usr/local/Cellar/gettext/0.18.1.1/bin:/Applications/Firefox 3.app/Contents/MacOS:/usr/local/php/bin:/Users/matt/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
export EDITOR="/usr/local/bin/vim"
export EVENT_NOKQUEUE=1
export NODE_PATH="/usr/local/lib/node_modules"
export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home"
test -r /sw/bin/init.sh && . /sw/bin/init.sh

# Ruby GC settings - https://gist.github.com/865706
export RUBY_HEAP_MIN_SLOTS=600000
export RUBY_HEAP_SLOTS_INCREMENT=10000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1.8
export RUBY_GC_MALLOC_LIMIT=59000000
export RUBY_HEAP_FREE_MIN=100000

# colour codes
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
LIGHT_CYAN="\[\033[1;36m\]"
LIGHT_PURPLE="\[\033[1;35m\]"
WHITE="\[\033[0;37m\]"
WHITE_BOLD="\[\033[1;37m\]"
GRAY="\[\033[1;30m\]"
COLOR_NONE="\[\e[0m\]"

# prompt functions
function is_git_repository {
  git branch > /dev/null 2>&1
}

function set_git_branch {
  # capture output of git status
  git_status="$(git status 2> /dev/null)"

  # get the time of last commit
  time=$(git log --format='%cr' -n1)
  git_time=$(sed "s/\([0-9]*\) \([ywdhms]\).*/\1\2/" <<< "$time")

  # set color based on clean/staged/unstaged
  if [[ ${git_status} =~ "working directory clean" ]]; then
    state="${GREEN}"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state="${YELLOW}"
  else
    state="${LIGHT_CYAN}"
  fi

  # set arrow icon based on status against remote
  remote_pattern="# Your branch is (.*) of"
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="↑ "
    else
      remote="↓ "
    fi
  else
    remote=""
  fi
  diverge_pattern="# Your branch and (.*) have diverged"
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="↕"
  fi

  # get the name of the branch
  branch_pattern="^# On branch ([^${IFS}]*)"
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
  fi

  GIT="$LIGHT_CYAN(${state}${branch} $WHITE_BOLD${remote}$GRAY${git_time}$LIGHT_CYAN)"
}

function set_bash_prompt {
  if is_git_repository ; then
    set_git_branch
  else
    GIT=''
  fi

  PS1="$BLUE[$WHITE\h:\w$BLUE]$GIT$COLOR_NONE\$ "
  PS2='> '
  PS4='+ '
}

# set the prompt
PROMPT_COMMAND=set_bash_prompt

# tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
