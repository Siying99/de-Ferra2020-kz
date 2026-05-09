# Replication Guide — de-Ferra2020-kz

This REMARK (Tier 2) reproduces **de Ferra, Mitman, and Romei (2020)**,
"Household heterogeneity and the transmission of foreign shocks,"
*Journal of International Economics* **124**, 103303.
DOI: https://doi.org/10.1016/j.jinteco.2020.103303

REMARK author: Siying Li (Johns Hopkins University)

---

## Full Replication in One Command

```bash
./reproduce.sh --comp full && ./reproduce.sh --docs
```

Expected runtime: **~35 minutes** on an Apple M4 Pro MacBook Pro (16 GB RAM).

---

## Staged Replication

### Stage 1 — Environment check (~1 min)
```bash
./reproduce.sh --envt
```

### Stage 2 — Phase A+B+C: calibration + Figs 1–3 (~5 min)
```bash
./reproduce.sh --comp min
```
Prints key quantitative results in terminal after finishing.

### Stage 3 — Phase D: Figs 4–5 (~25 min)
```bash
# (requires Stage 2 to have run first)
cd Code/Python && ./run_all.sh --phase=D
```

### Stage 4 — Rebuild PDF (~30s)
```bash
./reproduce.sh --docs
```

---

## What is Reproduced

| Paper Result | Method | Notes |
|-------------|--------|-------|
| Table 1 (calibration) | Python β-calibration via `brentq` | β = 0.98322 vs paper 0.983 |
| Figure 1 (credit supply paths) | Rouwenhorst Markov chain | Exact match |
| Figure 2 (consumption dynamics, expansion) | EGM + MIT-shock transition | Qualitative match |
| Figure 3 (welfare, expansion) | Distribution moments | Qualitative match |
| Figure 4 (consumption, contraction) | flex vs fixed FX solvers | Qualitative match |
| Figure 5 (output/exchange rate, contraction) | NKPC backward iteration | Qualitative match |

---

## Computational Pipeline

```
Phase A: Rouwenhorst → params → shock path → Figure 1  (~1 min)
Phase B: EGM → distribution → β-calibration → Table 1  (~1 min)
Phase C: Initial SS → transition → Figures 2–3          (~3 min)
Phase D: Flex contraction → Fixed contraction → Figs 4–5 (~25 min)
```

See `Code/Python/README.md` for detailed notebook-level documentation.

---

## Verifying Results

After `--comp min`:
```bash
cat Code/Python/output/calibration_summary.json
cat Code/Python/output/verification_table.md
```

After `--comp full`, also check:
```bash
ls -lh Figures/deFerra2020_fig*.png   # all 5 figures present
ls -lh Code/Python/output/*.npz       # all computed arrays present
```
