# Computational Workflows — de-Ferra2020-kz

## Overview

The Python pipeline is organised into four phases:

| Phase | Notebooks | Content | Runtime |
|-------|-----------|---------|---------|
| A | 01–04 | Rouwenhorst chain, parameter grids, shock path, Figure 1 | ~1 min |
| B | 05–08 | EGM steady state, stationary distribution, β-calibration, Table 1 | ~1 min |
| C | 09–11 | Initial + final steady state, credit-expansion transition, Figs 2–3 | ~2 min |
| D | 12–14 | Unexpected contraction (flex + fixed FX), Figs 4–5 | ~25 min |

Total: **~30–35 min** on a 2024 MacBook Pro M3 (16 GB RAM).

---

## Prerequisites

1. Python 3.12 installed (e.g. via conda using `binder/environment.yml`)
2. A Jupyter kernel named `deferra2020-kz` registered:
   ```bash
   python -m ipykernel install --user --name deferra2020-kz --display-name "Python (deferra2020-kz)"
   ```
3. TeX Live (for PDF compilation)

---

## Workflow 1 — Full end-to-end (recommended)

```bash
# From repo root
./reproduce.sh --comp full && ./reproduce.sh --docs
```

This:
1. Runs all 14 notebooks via `Code/Python/run_all.sh --phase=all`
2. Syncs figure PNGs to `Figures/`
3. Rebuilds `deFerra2020.pdf` with `latexmk`

---

## Workflow 2 — Step-by-step (for debugging)

```bash
cd Code/Python

# Phase A+B+C only (calibration + Figs 1-3)
./run_all.sh --phase=ABC

# Phase D only (requires ABC outputs, adds Figs 4-5)
./run_all.sh --phase=D

# Single notebook
KERNEL=deferra2020-kz jupyter nbconvert --to notebook --execute \
    --ExecutePreprocessor.kernel_name=deferra2020-kz \
    notebooks/07_calibrate_beta.ipynb --output notebooks/07_calibrate_beta_out.ipynb
```

---

## Workflow 3 — PDF only (no Python)

If pre-existing `.npz` files and figure PNGs exist (e.g. from a prior run):

```bash
./reproduce_min.sh      # <30 seconds
# or:
latexmk -pdf deFerra2020.tex
```

---

## Key Environment Variables for run_all.sh

| Variable | Default | Effect |
|----------|---------|--------|
| `KERNEL` | `deferra2020-kz` | Jupyter kernel name |
| `JUPYTER` | `jupyter` | Jupyter executable |
| `PHASE` | set by `--phase` | Which phase(s) to run |

---

## Expected Outputs After Full Run

- `Code/Python/output/calibration_summary.json` — β value and moment matches
- `Code/Python/output/verification_table.md` — Numerical comparisons
- `Figures/deFerra2020_fig{1-5}.png` — Figures 1–5
- `deFerra2020.pdf` — Compiled paper

---

## Runtime Breakdown (Measured, M3 MacBook Pro)

| Notebook | Phase | Wall time |
|----------|-------|-----------|
| 01 | A | ~2s |
| 02 | A | ~3s |
| 03 | A | ~2s |
| 04 | A | ~5s |
| 05 | B | ~12s |
| 06 | B | ~6s |
| 07 | B | ~18s |
| 08 | B | ~3s |
| 09 | C | ~8s |
| 10 | C | ~170s (fsolve refinement) |
| 11 | C | ~4s |
| 12 | D | ~300s |
| 13 | D | ~1200s |
| 14 | D | ~5s |

Phase D (12+13+14) dominates at ~25 min, mostly notebook 13 (fixed-FX solver).
