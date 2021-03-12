################################################################################
# Interactive shell environment
################################################################################

if [ -d $HOME/.zsh ]; then
  # source all files in ~/.zsh
  for zsh_config in $HOME/.zsh/*(.); do
    source $zsh_config
  done
fi

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
