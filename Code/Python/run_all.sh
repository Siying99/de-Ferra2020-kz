#!/bin/bash
# Run the full Python reproduction pipeline (Phases A, B, C, D).
#
# Executes notebooks 01-14 in order, in-place. Each notebook saves its outputs
# (.npz, .png, .md) to ./output/ and is loaded by later notebooks. Per-notebook
# wall-clock times are printed; a final total is reported at the end.
#
# Usage:
#   ./run_all.sh [--fast]   [--phase=ABC|D|all]
#
#   --fast        Set REFINE=False in 10_solve_transition.ipynb so that the
#                 ~150 s fsolve refinement is skipped (the MATLAB warm-start
#                 path is used directly, residual ~ 1.2e-4).
#   --phase=ABC   Only run Phases A-C (notebooks 01-11). Skip the contraction
#                 / Figures 4-5 (~25 min). Default behaviour: --phase=all.
#   --phase=D     Only run Phase D (notebooks 12-14). Assumes Phases A-C have
#                 already been run and produced output/transition_flex.npz.
#   --phase=all   Run everything (default).
#
# Requires the "de-Ferra 2020 (Python 3.12)" Jupyter kernel (see
# Code/Python/README.md).
#
# Wall-clock runtime estimates (single-core, M-class Apple silicon, May 2026):
#
#   Phase A (notebooks 01-04, Markov + grids + Fig 1):              < 30 s
#   Phase B (notebooks 05-08, EGM + dist + calibrate beta):       ~ 60 s
#   Phase C (notebooks 09-11, transitions + Figs 2-3):           ~3-5 min
#       09 initial+final SS:           ~ 30 s
#       10 transition (refine=True):   ~150 s
#       10 transition (refine=False):    ~5 s   (warm-start only)
#       11 Figs 2-3:                    ~ 5 s
#   Phase D (notebooks 12-14, contraction + Figs 4-5):          ~26-28 min
#       12 contraction flex (fsolve):     ~6 min
#       13 contraction fixed (LM):       ~20 min
#       14 Figs 4-5:                      ~5 s
#
#   --phase=ABC --fast:   < 1 min        (Phase A+B+C without refinement)
#   --phase=ABC:          ~3-5 min
#   --phase=all:        ~30-35 min       (full pipeline)

set -euo pipefail

cd "$(dirname "$0")"

KERNEL="${KERNEL:-deferra2020-kz}"
JUPYTER="${JUPYTER:-jupyter}"
TIMEOUT="${TIMEOUT:-2400}"          # 40 min per notebook (LM solver in nb13 is the bottleneck)

REFINE_FLAG=true
PHASE=all
for arg in "$@"; do
  case "$arg" in
    --fast)        REFINE_FLAG=false ;;
    --phase=ABC)   PHASE=ABC ;;
    --phase=D)     PHASE=D ;;
    --phase=all)   PHASE=all ;;
    *)             echo "[run_all] WARN: unknown arg '$arg'" >&2 ;;
  esac
done
[[ "$REFINE_FLAG" == "false" ]] && echo "[run_all] --fast: notebook 10 will use REFINE=False"
echo "[run_all] phase = $PHASE"

NOTEBOOKS_ABC=(
  notebooks/01_rouwenhorst.ipynb
  notebooks/02_params_and_grids.ipynb
  notebooks/03_shock_path.ipynb
  notebooks/04_figure1.ipynb
  notebooks/05_egm.ipynb
  notebooks/06_distribution.ipynb
  notebooks/07_calibrate_beta.ipynb
  notebooks/08_verify_table1.ipynb
  notebooks/09_initial_ss.ipynb
  notebooks/10_solve_transition.ipynb
  notebooks/11_figures_2_3.ipynb
)

NOTEBOOKS_D=(
  notebooks/12_contraction_flex.ipynb
  notebooks/13_contraction_fixed.ipynb
  notebooks/14_figures_4_5.ipynb
)

case "$PHASE" in
  ABC)  NOTEBOOKS=("${NOTEBOOKS_ABC[@]}") ;;
  D)    NOTEBOOKS=("${NOTEBOOKS_D[@]}") ;;
  all)  NOTEBOOKS=("${NOTEBOOKS_ABC[@]}" "${NOTEBOOKS_D[@]}") ;;
esac

# If --fast, swap REFINE flag in notebook 10 (idempotent). Targets the JSON
# code-cell line `"REFINE = True\n",` (with trailing comma) to avoid touching
# the markdown narrative which also mentions the flag name.
if [[ "$REFINE_FLAG" == "false" ]]; then
  sed -i.bak 's/"REFINE = True\\n",/"REFINE = False\\n",/' notebooks/10_solve_transition.ipynb || true
fi

START_ALL=$(date +%s)
declare -a NB_TIMES=()

for nb in "${NOTEBOOKS[@]}"; do
  echo
  echo "=== Running $nb ==="
  T0=$(date +%s)
  $JUPYTER nbconvert --to notebook --execute --inplace \
    --ExecutePreprocessor.kernel_name="$KERNEL" \
    --ExecutePreprocessor.timeout="$TIMEOUT" \
    "$nb"
  T1=$(date +%s)
  ELAPSED=$((T1 - T0))
  NB_TIMES+=("${nb}=${ELAPSED}s")
  echo "    [$nb finished in ${ELAPSED}s]"
done

# Restore default REFINE=True if we modified it.
if [[ "$REFINE_FLAG" == "false" ]]; then
  if [[ -f notebooks/10_solve_transition.ipynb.bak ]]; then
    mv notebooks/10_solve_transition.ipynb.bak notebooks/10_solve_transition.ipynb
  fi
fi

END_ALL=$(date +%s)
TOTAL=$((END_ALL - START_ALL))

echo
echo "================================================================"
echo "[run_all] Per-notebook wall-clock times:"
for entry in "${NB_TIMES[@]}"; do
  printf "    %s\n" "$entry"
done
TOTAL_MIN=$((TOTAL / 60))
TOTAL_SEC=$((TOTAL % 60))
echo "[run_all] TOTAL: ${TOTAL}s (~${TOTAL_MIN}m ${TOTAL_SEC}s)"
echo "================================================================"
echo
echo "[run_all] Outputs in $(pwd)/output/"
ls output/*.png output/*.md 2>/dev/null || true
