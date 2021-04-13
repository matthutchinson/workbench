########################################################################
# non-interactive shell environment
########################################################################

# for homebrew
export PATH="/opt/homebrew/bin:/usr/local/sbin:$PATH"
# rust
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

if [ -e /Users/matt/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/matt/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
