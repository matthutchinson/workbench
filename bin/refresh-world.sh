#!/bin/bash
# Refresh script for Shopify world apps
# Refreshes storefront and shopify apps if safe conditions are met
#
# To force laptop wake daily at a specific time, use:
#   sudo pmset repeat cancel && sudo pmset repeat wake MTWRFSU 08:50:00

set -euo pipefail

LOG_FILE="$HOME/Library/Logs/world-refresh.log"
STOREFRONT_DIR="$HOME/world/trees/root/src/areas/core/storefront"
SHOPIFY_DIR="$HOME/world/trees/root/src/areas/core/shopify"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

log "=== Starting world refresh ==="

# cd to storefront dir first - all git commands run from here
cd "$STOREFRONT_DIR"

# Check 1: Verify we're on main branch
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null)
if [[ "$CURRENT_BRANCH" != "main" ]]; then
    log "SKIPPED: Not on main branch (currently on: $CURRENT_BRANCH)"
    exit 0
fi

# Check 2: Verify no staged or unstaged changes in the checked-out areas
# Only check storefront and shopify dirs to avoid sparse checkout "deleted" false positives
STOREFRONT_RELPATH="areas/core/storefront"
SHOPIFY_RELPATH="areas/core/shopify"

if ! git diff-index --quiet HEAD -- "$STOREFRONT_RELPATH" "$SHOPIFY_RELPATH" 2>/dev/null; then
    log "SKIPPED: Uncommitted staged changes detected in storefront or shopify"
    exit 0
fi

if ! git diff-files --quiet -- "$STOREFRONT_RELPATH" "$SHOPIFY_RELPATH" 2>/dev/null; then
    log "SKIPPED: Uncommitted unstaged changes detected in storefront or shopify"
    exit 0
fi

log "Conditions met: on main branch, no uncommitted changes"

# Fetch and reset to latest main
# Using fetch + reset instead of pull because sparse checkout shows "deleted" files
# that block git pull --rebase, even though we've verified no real changes exist
log "Fetching latest from origin..."
if ! git fetch origin main >> "$LOG_FILE" 2>&1; then
    log "ERROR: Git fetch failed"
    exit 1
fi

log "Resetting to origin/main..."
if git reset --hard origin/main >> "$LOG_FILE" 2>&1; then
    log "Reset successful"
    # Log the latest commit SHA and message
    COMMIT_SHA=$(git rev-parse HEAD)
    COMMIT_MSG=$(git log -1 --pretty=format:'%s')
    log "Updated to commit: $COMMIT_SHA"
    log "Commit message: $COMMIT_MSG"
else
    log "ERROR: Git reset failed"
    exit 1
fi

# Function to run dev up with timeout for sudo prompt
run_dev_up() {
    local app_dir="$1"
    local app_name="$2"

    log "Running dev up for $app_name..."
    cd "$app_dir"

    # Use SUDO_ASKPASS=/bin/false to make sudo fail immediately instead of prompting
    # Timeout after 10 minutes in case dev up hangs
    if timeout 600 bash -c '
        export SUDO_ASKPASS=/bin/false
        shadowenv exec -- /opt/dev/bin/dev up 2>&1
    ' >> "$LOG_FILE" 2>&1; then
        log "dev up for $app_name completed successfully"
        return 0
    else
        local exit_code=$?
        if [[ $exit_code -eq 124 ]]; then
            log "WARNING: dev up for $app_name timed out (possibly waiting for sudo password)"
        else
            log "WARNING: dev up for $app_name failed with exit code $exit_code"
        fi
        return 1
    fi
}

# Run dev up for storefront
run_dev_up "$STOREFRONT_DIR" "storefront" || true

# Run dev up for shopify (continue even if storefront failed)
run_dev_up "$SHOPIFY_DIR" "shopify" || true

log "=== World refresh completed ==="
