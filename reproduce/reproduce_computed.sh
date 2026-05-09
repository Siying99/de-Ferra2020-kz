#!/bin/bash
# reproduce_computed.sh  --  Phase A+B+C+D  (full Python pipeline)
#
# This script runs all 14 de Ferra 2020 Python notebooks via run_all.sh.
# Phase D (notebooks 12-14, unexpected contraction) adds ~25 minutes.
# Omit --full to run Phases A-C only (~3-5 min).
#
# Called by:  ./reproduce.sh --comp [min|full]
#   min  → Phases A-C only  (run_all.sh --phase=ABC)
#   full → Phases A-C+D      (run_all.sh --phase=all)
#
# Requires: Python 3.12 with the deferra2020-kz kernel registered.
# See Code/Python/README.md for setup.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PYTHON_DIR="$PROJECT_ROOT/Code/Python"

# Detect the scope requested by reproduce.sh (env var COMP_SCOPE, default min)
COMP_SCOPE="${COMP_SCOPE:-min}"

echo "================================================================="
echo " de-Ferra2020-kz Python pipeline"
echo " COMP_SCOPE = $COMP_SCOPE"
echo "================================================================="

if [[ ! -f "$PYTHON_DIR/run_all.sh" ]]; then
  echo "ERROR: $PYTHON_DIR/run_all.sh not found."
  exit 1
fi
chmod +x "$PYTHON_DIR/run_all.sh"

cd "$PYTHON_DIR"

case "$COMP_SCOPE" in
  min)
    echo "Running Phases A+B+C (notebooks 01-11, ~3-5 min) ..."
    KERNEL="deferra2020-kz" JUPYTER="jupyter" ./run_all.sh --phase=ABC
    ;;
  full|max)
    echo "Running Phases A+B+C+D (notebooks 01-14, ~30-35 min) ..."
    KERNEL="deferra2020-kz" JUPYTER="jupyter" ./run_all.sh --phase=all
    ;;
  *)
    echo "ERROR: unknown COMP_SCOPE '$COMP_SCOPE'. Expected: min|full|max."
    exit 1
    ;;
esac

echo ""
echo "Python pipeline complete. Outputs in $PYTHON_DIR/output/"
echo "Figures synced to $PROJECT_ROOT/Figures/"

# =============================================================================
# REMOVE PREGENERATED FLAG AFTER SUCCESSFUL COMPUTATION
# =============================================================================
# After computational results are regenerated, remove the flag file that
# triggers PREGENERATED markers in table/figure captions.
#
FLAG_FILE="$PROJECT_ROOT/reproduce/.results_pregenerated"

if [[ -f "$FLAG_FILE" ]]; then
    echo ""
    echo "========================================"
    echo "✅ Computation Complete"
    echo "========================================"
    echo ""
    echo "Removing PREGENERATED flag file..."
    rm -f "$FLAG_FILE"
    echo "✓ Flag removed - table/figure captions will no longer show PREGENERATED markers"
    echo "  (Recompile deFerra2020.tex to see updated captions)"
    echo ""
else
    echo ""
    echo "ℹ️  No PREGENERATED flag file found (already removed or never created)"
    echo ""
fi
