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
# Benchmarking - https://blog.jonlu.ca/posts/speeding-up-zsh
################################################################################

# time zsh -i -c "print -n"
# zmodload zsh/zprof
# then run `zprof` in new shells

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
