eval "$(/opt/homebrew/bin/brew shellenv)"

if [[ ! $HOST =~ ^shopify ]]; then
  eval "$(mise hook-env --shell zsh)"
fi
