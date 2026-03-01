#!/bin/bash
# Fever Dream — walkthrough test runner
# Thin wrapper that delegates to the shared testing framework.
#
# Fever Dream has no scoring system, so the generic framework's score-based
# pass/fail always returns FAIL. This wrapper runs it with --quiet to get
# the transcript, then checks for the endgame text directly.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
I7_ROOT="$(dirname "$(dirname "$PROJECT_DIR")")"

# Pass through all args but inject --quiet and capture exit code
# First, run the framework to get diagnostics and save the transcript
bash "$I7_ROOT/tools/testing/run-walkthrough.sh" --config "$SCRIPT_DIR/project.conf" "$@" 2>&1
FRAMEWORK_EXIT=$?

# Source config for WON_PATTERNS
export PROJECT_DIR
source "$SCRIPT_DIR/project.conf"

# For scoreless games, override pass/fail with endgame detection
if [[ "${SCORELESS_GAME:-false}" == "true" ]]; then
    OUTPUT_FILE="$PRIMARY_OUTPUT_FILE"
    if [[ -f "$OUTPUT_FILE" ]] && grep -qiP "${WON_PATTERNS}" "$OUTPUT_FILE" 2>/dev/null; then
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
