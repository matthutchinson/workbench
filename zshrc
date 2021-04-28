################################################################################
# Interactive shell environment
################################################################################

################################################################################
# homebrew - with PATH for arm M1 install (older node for M1)
################################################################################
[ -d "/opt/homebrew" ] && export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
[ -d "/usr/local" ] && export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
[ -d "/opt/homebrew/opt/node@14" ] && export PATH="/opt/homebrew/opt/node@14/bin:$PATH"

# source all files in ~/.zsh
if [ -d $HOME/.zsh ]; then
  for zsh_config in $HOME/.zsh/*(.); do
    source $zsh_config
  done
fi

################################################################################
# chruby - no autoswitch, use .envrc for that
################################################################################
source "$(brew --prefix)/opt/chruby/share/chruby/chruby.sh"

################################################################################
# direnv - https://github.com/direnv/direnv (see ~/.direnvrc and ~/.envrc)
################################################################################
export DIRENV_LOG_FORMAT=  # comment this to debug or be verbose
eval "$(direnv hook zsh)"

################################################################################
# shopify dev - https://github.com/Shopify/dev
################################################################################
[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh

################################################################################
# Benchmarking - https://blog.jonlu.ca/posts/speeding-up-zsh
################################################################################
# add `zmodload zsh/zprof` above
# then run `zprof` in new shells
