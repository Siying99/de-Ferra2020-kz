#!/bin/bash
# reproduce_min.sh — Minimal (fast) reproduction for REMARK compliance
#
# Builds deFerra2020.pdf from existing .npz outputs + pre-generated figures.
# Expected runtime: < 30 seconds (LaTeX only, no Python).
#
# For a more thorough reproduction that also re-runs Phase A+B+C of the Python
# pipeline, use:
#   ./reproduce.sh --comp          # Phases A+B+C (~3-5 min)
#   ./reproduce.sh --comp --full   # Phases A+B+C+D (~30-35 min, incl. Figs 4-5)
#
# For the full menu of options, see: ./reproduce.sh --help
#
# REMARK tier: 2 (code + calibration reproducible from a clean clone)

set -e

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT_DIR"

echo "================================================================="
echo " de-Ferra2020-kz  —  Minimal Reproduction"
echo "================================================================="
echo " Paper:   Household Heterogeneity and the Transmission of"
echo "          Foreign Shocks"
echo " Authors: Sergio de Ferra, Kurt Mitman, Federica Romei"
echo " Journal: Journal of International Economics, 124, 103303 (2020)"
echo " DOI:     10.1016/j.jinteco.2020.103303"
echo " REMARK author: Siying Li (Johns Hopkins University)"
echo " Tier: 2 (calibration + Figs 1-5 reproducible from scratch)"
echo "================================================================="
echo ""
echo "Step 1/2: Compiling deFerra2020.pdf with latexmk ..."
echo ""

if ! command -v latexmk &>/dev/null; then
  echo "ERROR: latexmk not found. Install TeX Live (texlive-full) or MiKTeX."
  exit 1
fi

latexmk -pdf -interaction=nonstopmode -file-line-error deFerra2020.tex 2>&1 \
  | grep -E "(Warning|Error|!|Saved|pages)" || true

echo ""
echo "Step 2/2: Verifying output ..."
if [[ -f deFerra2020.pdf ]]; then
  SIZE=$(du -h deFerra2020.pdf | cut -f1)
  echo "  ✓  deFerra2020.pdf   ($SIZE)"
else
  echo "  ERROR: deFerra2020.pdf was not produced. See deFerra2020.log."
  exit 1
fi

for f in Figures/deFerra2020_fig1_credit_supply.png \
         Figures/deFerra2020_fig2.png \
         Figures/deFerra2020_fig3.png \
         Figures/deFerra2020_fig4.png \
         Figures/deFerra2020_fig5.png; do
  [[ -f "$f" ]] && echo "  ✓  $f" || echo "  ✗  $f  (run ./reproduce.sh --comp to regenerate)"
done

echo ""
echo "================================================================="
echo " Minimal reproduction complete."
echo " Primary artefact:  deFerra2020.pdf"
echo ""
echo " To regenerate figures from scratch (requires Python 3.12):"
echo "   ./reproduce.sh --comp            # Phases A-C  (~3-5 min)"
echo "   ./reproduce.sh --comp --full     # Phases A-D  (~30-35 min, incl. Figs 4-5)"
echo "================================================================="
