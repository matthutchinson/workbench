#!/bin/bash

# aliases, helpers and secrets
if [ -f ~/.aliases ]; then . ~/.aliases ; fi
if [ -f ~/.selecta ]; then . ~/.selecta ; fi
if [ -f ~/.secret ]; then . ~/.secret ; fi

# exports
export TERM="screen-256color" # use screen-256color to play nicer with tmux
export PATH="/Users/matt/bin:/Applications/Postgres.app/Contents/Versions/latest/bin:/Applications/Firefox.app/Contents/MacOS:/usr/local/php/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
export EDITOR="/usr/local/bin/vim"
export EVENT_NOKQUEUE=1
export NODE_PATH="/usr/local/lib/node_modules"
export CLICOLOR=1 # ls coloring
export SERVER_SOFTWARE='pow'
export XCODE="`xcode-select --print-path`"
export ORDERWEB_HOME="/u/apps/orderweb"

# Ruby GC - https://gist.github.com/865706
export RUBY_HEAP_SLOTS_INCREMENT=10000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1.8
export RUBY_GC_HEAP_FREE_SLOTS=100000
export RUBY_GC_HEAP_INIT_SLOTS=600000
# https://gist.github.com/1688857
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_GC_HEAP_FREE_SLOTS=500000

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

  # get git repo info
  # tips from here: https://gist.github.com/jkakar/4845875288eef72cc2c6
  local repo_info rev_parse_exit_code
	repo_info="$(git rev-parse --git-dir --short HEAD 2>/dev/null)"
	rev_parse_exit_code="$?"

  local short_sha inside_gitdir g git_wtf
  if [ "$rev_parse_exit_code" = "0" ]; then
    g="${repo_info%$'\n'*}"
    short_sha="${repo_info##*$'\n'}"
  fi

  # wtf, are we rebasing, bisecting, merging, cherry-picking or reverting?
  local git_wtf=""
  if [ -d "$g/rebase-merge" ]; then
    if [ -f "$g/rebase-merge/interactive" ]; then
      git_wtf="REBASE-i"
    else
      git_wtf="REBASE-m"
    fi
  else
    if [ -f "$g/MERGE_HEAD" ]; then
      git_wtf="🎯 "
    elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
      git_wtf="🍒 "
    elif [ -f "$g/REVERT_HEAD" ]; then
      git_wtf="🔧 "
    elif [ -f "$g/BISECT_LOG" ]; then
      git_wtf="🔍 "
    fi
  fi
  if [ -n "$git_wtf" ]; then
    git_wtf="$DARK_GRAY|$GRAY${git_wtf}"
  fi

  # set color based on clean/staged/unstaged
  if [[ ${git_status} =~ "nothing to commit" ]]; then
    state="${GREEN}"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state="${YELLOW}"
  else
    state="${ORANGE}"
  fi

  # set arrow icon based on status against remote
  if [[ ${git_status} =~ "Your branch is ahead" ]]; then
    remote="↑"
  elif [[ ${git_status} =~ "Your branch is behind" ]]; then
    remote="↓"
  elif [[ ${git_status} =~ "Your branch and (.*) have diverged" ]]; then
    remote="↕"
  else
    remote=""
  fi

  # get the name of the branch
  branch_pattern="^On branch ([^${IFS}]*)"
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
    # shortcut for current branch name and story id
    export br=${branch}
    export story_id_from_git_branch="$(echo $branch | perl -ne 'print /(.*)\//')"

    # truncate longish branch names
    if [ ${#branch} -gt 30 ]
    then
      branch=$(echo $branch | cut -c1-28)..
    fi
  fi


  GIT_PROMPT="$LIGHT_BLUE(${state}${branch}${git_time}${git_wtf}$WHITE_BOLD${remote}$LIGHT_BLUE)"
}

# set the prompts
function set_bash_prompt {
  if is_git_repository ; then
    set_git_prompt
  else
    GIT_PROMPT=''
  fi

  PS1="$LIGHT_BLUE[$GRAY\u$DARK_GRAY@$GRAY\h:$WHITE\W$LIGHT_BLUE]$GIT_PROMPT$COLOR_NONE$ "
  PS2='> '
  PS4='+ '
}

# set the prompt
PROMPT_COMMAND=set_bash_prompt

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# scmpuff
eval "$(scmpuff init -s)"

# add only trusted projects' bin directory to $PATH
# enable with `mkdir .git/safe` in the root of repositories you trust
 export PATH=".git/safe/../../bin:$PATH"

export NVM_DIR="/Users/matt/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
