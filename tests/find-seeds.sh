#!/bin/bash
# Fever Dream seed sweep (wrapper)
# Delegates to the generic testing framework with Fever Dream-specific config.
#
# Usage:
#   bash tests/find-seeds.sh                # default sweep
#   bash tests/find-seeds.sh --max 500      # search range (default: 200)
#   bash tests/find-seeds.sh --stop         # stop on first pass (default)
#   bash tests/find-seeds.sh --no-stop      # continue sweep after finding pass

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
CONFIG="$SCRIPT_DIR/project.conf"

# Platform-aware ifhub root
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    I7_ROOT="/c/code/ifhub"
else
    I7_ROOT="/mnt/c/code/ifhub"
fi

exec bash "$I7_ROOT/tools/testing/find-seeds.sh" --config "$CONFIG" "$@"
