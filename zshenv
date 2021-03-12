########################################################################
# non-interactive shell environment
########################################################################

# for homebrew
export PATH="/usr/local/sbin:$PATH"
if [ -e /Users/matt/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/matt/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
