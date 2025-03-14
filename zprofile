eval "$(/opt/homebrew/bin/brew shellenv)"

HOSTNAME=$(hostname)

if [[ $HOSTNAME =~ ^dagobah ]]; then
  eval "$(mise hook-env --shell zsh)"
fi
