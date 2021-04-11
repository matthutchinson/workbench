########################################################################
# non-interactive shell environment
########################################################################

# for homebrew
export PATH="/opt/homebrew/bin:/usr/local/sbin:$PATH"
if [ -e /Users/matt/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/matt/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
source "$HOME/.cargo/env"
