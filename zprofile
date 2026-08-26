eval "$(/opt/homebrew/bin/brew shellenv)"

HOSTNAME=$(hostname)

if [[ $HOSTNAME =~ ^dagobah ]]; then
  eval "$(mise hook-env --shell zsh)"
fi

# Added by tec agent
[[ ! -o interactive ]] && [[ -d /Users/matt/.local/state/tec/toolchain/base_profile/bin ]] && export PATH="/Users/matt/.local/state/tec/toolchain/base_profile/bin:$PATH"
