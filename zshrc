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
# shopify dev - https://github.com/Shopify/dev
################################################################################
[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
[ -d $(brew --prefix)/Caskroom/google-cloud-sdk ] && source $(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
# ensure chruby exists in non-interactive shells
if [ -d /opt/dev/sh/chruby ]; then
  [[ -f /opt/dev/sh/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }
fi

################################################################################
# Benchmarking - https://blog.jonlu.ca/posts/speeding-up-zsh
################################################################################
# add `zmodload zsh/zprof` above
# then run `zprof` in new shells

