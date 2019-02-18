########################################################################
# interactive shell environment
########################################################################

if [ -d $HOME/.zsh ]; then
  for zsh_config in $HOME/.zsh/*; do
    source $zsh_config
  done
fi
