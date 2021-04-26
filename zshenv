########################################################################
# non-interactive shell environment
########################################################################

# source brew executables (for Intel and M1 arch)
[ -d "/opt/homebrew" ] && export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
[ -d "/usr/local" ] && export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# rust
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

if [ -e /Users/matt/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/matt/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
