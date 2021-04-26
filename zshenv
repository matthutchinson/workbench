########################################################################
# non-interactive shell environment
########################################################################

# rust
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

if [ -e /Users/matt/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/matt/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
