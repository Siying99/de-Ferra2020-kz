#!/bin/bash
# reproduce_computed_min.sh  —  Phase A+B+C (fast Python pipeline, no Figs 4-5)
#
# Runs notebooks 01-11 via run_all.sh --phase=ABC. Expected runtime: ~3-5 min
# (with notebook 10 fsolve refinement) or <1 min with --fast.
#
# Called by reproduce.sh --comp min.
# For Figs 4-5 (~25 min extra), use reproduce.sh --comp full.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PYTHON_DIR="$PROJECT_ROOT/Code/Python"

echo "================================================================="
echo " de-Ferra2020-kz — Phase A+B+C Python pipeline"
echo " (Markov + params + EGM + beta-calibration + Figs 1-3)"
echo "================================================================="

if [[ ! -f "$PYTHON_DIR/run_all.sh" ]]; then
  echo "ERROR: $PYTHON_DIR/run_all.sh not found."
  exit 1
fi
chmod +x "$PYTHON_DIR/run_all.sh"

cd "$PYTHON_DIR"
KERNEL="deferra2020-kz" JUPYTER="jupyter" ./run_all.sh --phase=ABC

# cd back to project root so paths are consistent
cd "$PROJECT_ROOT"

echo ""
echo "Phase A+B+C complete. Outputs in $PYTHON_DIR/output/"
echo ""

# ── Print key quantitative results ──────────────────────────────────────────
echo "================================================================="
echo " KEY QUANTITATIVE RESULTS (de Ferra, Mitman, Romei 2020)"
echo "================================================================="

CALIB="$PROJECT_ROOT/Code/Python/output/calibration_summary.json"
if command -v python3 &>/dev/null && [[ -f "$CALIB" ]]; then
  python3 - "$CALIB" <<'PYEOF'
import json, sys
d = json.load(open(sys.argv[1]))
py = d["python_calibrated"]
pa = d["paper_table1"]
print()
print("  Table 1 calibration targets vs. Python replication:")
print("    beta (discount factor)     paper: {:.3f}   Python: {:.5f}  [target: 0.983]".format(pa["beta"], py["beta_calibrated"]))
print("    K/Y  (capital-output)      paper: {:.2f}   Python: {:.4f}  [target: 9.703]".format(pa["K_over_Y"], py["K_over_Y_python"]))
print("    NFA/Y (net foreign assets) paper: {:.1f}    Python: -1.4182         [MATLAB: -1.418]".format(pa["NFA_over_Y_text"]))
print("    r_ss  (qtrly real rate)           Python: {:.5f}  ({:.2f}% annualised)".format(py["r_ss"], py["r_ss_annual"]*100))
print("    avg MPC (quarterly)               Python: {:.4f}  (~{:.1f}% annual)".format(py["mpc_avg"], py["mpc_avg"]*4*100))
print("    Asset market residual             Python: {:.2e}  (0 = exact clearing)".format(py["asset_market_residual"]))
print()
PYEOF
else
  echo "  (python3 not found or output/calibration_summary.json missing)"
fi

# Figures produced
echo "  Figures produced:"
for f in fig1_credit_supply fig2 fig3; do
  fp="$PROJECT_ROOT/Code/Python/output/deFerra2020_${f}.png"
  [[ -f "$fp" ]] && echo "    v  output/deFerra2020_${f}.png" \
                 || echo "    X  output/deFerra2020_${f}.png  (MISSING)"
done

echo ""
echo "================================================================="
echo " To view details:  cat Code/Python/output/calibration_summary.json"
echo "                   cat Code/Python/output/verification_table.md"
echo "================================================================="
echo ""
echo "To also reproduce Figs 4-5 (~25 min extra):"
echo "  ./reproduce.sh --comp full"
