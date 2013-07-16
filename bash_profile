# aliases and secrets
if [ -f ~/.aliases ]; then . ~/.aliases ; fi
if [ -f ~/.secret ]; then . ~/.secret ; fi

# exports
export TERM="screen-256color" # use screen-256color to play nicer with tmux
export PATH="/Users/matt/bin:/usr/local/opt/gettext/bin:/Applications/Firefox.app/Contents/MacOS:/usr/local/php/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
export EDITOR="/usr/bin/vi"
export EVENT_NOKQUEUE=1
export NODE_PATH="/usr/local/lib/node_modules"
export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home"

# Ruby GC - https://gist.github.com/865706
export RUBY_HEAP_MIN_SLOTS=600000
export RUBY_HEAP_SLOTS_INCREMENT=10000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1.8
export RUBY_HEAP_FREE_MIN=100000
# https://gist.github.com/1688857
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_FREE_MIN=500000

# colours
ORANGE="\[\033[0;38;05;136m\]"
LIGHT_BLUE="\[\033[0;38;05;74m\]"
YELLOW="\[\033[0;38;05;184m\]"
GREEN="\[\033[0;38;05;77m\]"
WHITE="\[\033[0;38;05;255m\]"
WHITE_BOLD="\[\033[1;38;05;255m\]"
GRAY="\[\033[0;38;05;244m\]"
DARK_GRAY="\[\033[0;38;05;239m\]"
COLOR_NONE="\[\033[00m\]"

# git prompt functions
function is_git_repository {
  git branch > /dev/null 2>&1
}

function set_git_prompt {
  # capture output of git status
  git_status="$(git status 2> /dev/null)"

  # get the time of last commit
  log_time=$(git log --format='%cr' -n1 2> /dev/null)
  git_time=$(sed "s/\([0-9]*\) \([ywdhms]\).*/\1\2/" <<< "$log_time")
  if [ -n "$git_time" ]; then
    git_time="$DARK_GRAY|$GRAY${git_time}"
  fi

  # set color based on clean/staged/unstaged
  if [[ ${git_status} =~ "working directory clean" ]]; then
    state="${GREEN}"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state="${YELLOW}"
  else
    state="${ORANGE}"
  fi

  # set arrow icon based on status against remote
  remote_pattern="# Your branch is (.*) of"
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="↑"
    else
      remote="↓"
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

  GIT_PROMPT="$LIGHT_BLUE(${state}${branch}${git_time}$WHITE_BOLD${remote}$LIGHT_BLUE)"
}

# set the prompts
function set_bash_prompt {
  if is_git_repository ; then
    set_git_prompt
  else
    GIT_PROMPT=''
  fi

  PS1="$LIGHT_BLUE[$WHITE\W$LIGHT_BLUE]$GIT_PROMPT$COLOR_NONE$ "
  PS2='> '
  PS4='+ '
}

# set the prompt
PROMPT_COMMAND=set_bash_prompt

# tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# ht
eval "$($HOME/.ht/bin/ht init -)"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
