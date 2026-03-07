#!/bin/bash
# Fever Dream walkthrough test runner (wrapper)
# Delegates to the generic testing framework with Fever Dream-specific config.
#
# Fever Dream has no scoring system, so the generic framework's score-based
# pass/fail always returns FAIL. This wrapper runs it normally, then checks
# for the endgame text directly to override the result.
#
# Usage:
#   bash tests/run-walkthrough.sh                  # Golden seed
#   bash tests/run-walkthrough.sh --seed 42        # Override seed
#   bash tests/run-walkthrough.sh --no-seed        # True randomness
#   bash tests/run-walkthrough.sh --diff           # Compare output vs saved baseline
#   bash tests/run-walkthrough.sh --quiet          # Suppress diagnostic output, just exit code
#   bash tests/run-walkthrough.sh --no-save        # Don't overwrite saved output file

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
CONFIG="$SCRIPT_DIR/project.conf"

# Platform-aware ifhub root
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    I7_ROOT="/c/code/ifhub"
else
    I7_ROOT="/mnt/c/code/ifhub"
fi

# Run the framework to get diagnostics and save the transcript
bash "$I7_ROOT/tools/testing/run-walkthrough.sh" --config "$CONFIG" "$@" 2>&1
FRAMEWORK_EXIT=$?

# Source config for WON_PATTERNS
export PROJECT_DIR
source "$CONFIG"

# For scoreless games, override pass/fail with endgame detection
if [[ "${SCORELESS_GAME:-false}" == "true" ]]; then
    OUTPUT_FILE="$PRIMARY_OUTPUT_FILE"
    if [[ -f "$OUTPUT_FILE" ]] && grep -qiE "${WON_PATTERNS}" "$OUTPUT_FILE" 2>/dev/null; then
        echo ""
        echo "Override: PASS (scoreless game — endgame text detected)"
        exit 0
    else
        echo ""
        echo "Override: FAIL (scoreless game — endgame text NOT detected)"
        exit 1
    fi
fi

exit $FRAMEWORK_EXIT
