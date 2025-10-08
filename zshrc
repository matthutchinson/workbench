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
# Brew
################################################################################

HOMEBREW_PREFIX=/opt/homebrew

eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"

################################################################################
# ENV Tooling
################################################################################

HOSTNAME=$(hostname)

if [[ $HOSTNAME =~ ^dagobah ]]; then
  eval "$($HOMEBREW_PREFIX/opt/mise/bin/mise activate zsh)"
fi

export GOPATH="$HOME/go"
export NODE_PATH="$HOMEBREW_PREFIX/lib/node_modules:$NODE_PATH"
export PATH="$GOPATH/bin:$HOMEBREW_PREFIX/share/npm/bin:/usr/local/bin:/usr/local/sbin:$PATH"

################################################################################
# PATH
################################################################################

# Don't hash command lookups, allowing us to use ./bin/* commands relative to
# the current working directory.
export PATH="./bin:$PATH"
set +h

# add home bin path
export PATH=~/bin:$PATH

# shopify
if [[ $HOSTNAME != dagobah ]]; then
  [ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
  [ -f $HOME/.shopify/zshrc.sh ] && source $HOME/.shopify/zshrc.sh
  [[ -f /opt/dev/sh/chruby/chruby.sh ]] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }
  [[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)
  [ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
fi

################################################################################
# Benchmarking - https://blog.jonlu.ca/posts/speeding-up-zsh
################################################################################
# add `zmodload zsh/zprof` above
# then run `zprof` in new shells

# Shopify Hydrogen alias to local projects
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'

# Added by tec agent
[[ -x /Users/matt/.local/state/tec/profiles/base/current/global/init ]] && eval "$(/Users/matt/.local/state/tec/profiles/base/current/global/init zsh)"
