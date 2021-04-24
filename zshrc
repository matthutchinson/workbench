################################################################################
# Interactive shell environment
################################################################################

# for alt homebrew e.g. ARM (Apple M1)
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin::$PATH"

# source all files in ~/.zsh
if [ -d $HOME/.zsh ]; then
  for zsh_config in $HOME/.zsh/*(.); do
    source $zsh_config
  done
fi

################################################################################
# chruby - no autoswitch, use .envrc for that
################################################################################
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh

################################################################################
# direnv - https://github.com/direnv/direnv (see ~/.direnvrc and ~/.envrc)
################################################################################
export DIRENV_LOG_FORMAT=  # comment this out to be more verbose
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
