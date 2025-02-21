eval "$(/opt/homebrew/bin/brew shellenv)"

HOSTNAME=$(hostname)

if [[ ! $HOSTNAME =~ ^shopify ]]; then
  eval "$(mise hook-env --shell zsh)"
fi
