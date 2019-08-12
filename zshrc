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

export DIRENV_LOG_FORMAT=  # uncomment to debug direnv
eval "$(direnv hook zsh)"

################################################################################
# Benchmarking - https://blog.jonlu.ca/posts/speeding-up-zsh
################################################################################

# time zsh -i -c "print -n"
# add `zmodload zsh/zprof` above
# then run `zprof` in new shells
