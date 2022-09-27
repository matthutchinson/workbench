################################################################################
# Interactive shell environment
################################################################################

################################################################################
# brew - https://brew.sh
################################################################################
[ -d "/opt/homebrew" ] && export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
[ -d "/usr/local" ] && export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

################################################################################
# source files in ~/.zsh
################################################################################
if [ -d $HOME/.zsh ]; then
  for zsh_config in $HOME/.zsh/*(.); do
    source $zsh_config
  done
fi

################################################################################
# direnv - https://github.com/direnv/direnv
################################################################################
export DIRENV_LOG_FORMAT=  # comment this to debug or be verbose
eval "$(direnv hook zsh)"

################################################################################
# PATH
################################################################################
export PATH=~/bin:$PATH

# Don't hash command lookups, allowing us to use ./bin/* commands relative to 
# the current working directory.
export PATH="./bin:$PATH"
set +h

################################################################################
# Brew
################################################################################

if [ -d /opt/homebrew ]; then
  HOMEBREW_PREFIX=/opt/homebrew
else
  HOMEBREW_PREFIX=/usr/local
fi

eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"

################################################################################
# 37signals
################################################################################

eval "$(rbenv init --no-rehash -)"
eval "$(nodenv init --no-rehash -)"
eval "$(work init -)"
eval "$(37 init -)"

export GOPATH="$HOME/go"
export NODE_PATH="$(brew --prefix)/lib/node_modules:$NODE_PATH"
export PATH="$HOME/.rbenv/bin:$GOPATH/bin:$(brew --prefix)/share/npm/bin:/usr/local/bin:/usr/local/sbin:$PATH"

################################################################################
# Benchmarking - https://blog.jonlu.ca/posts/speeding-up-zsh
################################################################################
# add `zmodload zsh/zprof` above
# then run `zprof` in new shells