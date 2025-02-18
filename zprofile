eval "$(/opt/homebrew/bin/brew shellenv)"

HOSTNAME=$(hostname)

if [[ ! $HOSTNAME =~ ^Mac ]]; then
  eval "$(mise hook-env --shell zsh)"
fi
