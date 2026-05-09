# AI Quick Start Guide — de-Ferra2020-kz

**Welcome, AI system! This is your entry point to understanding this research repository.**

## What is this repository?

**de-Ferra2020-kz** is a REMARK (Replication and Exploration Made using ARK, Tier 2)
for the paper:

> **"Household heterogeneity and the transmission of foreign shocks"**
> Sergio de Ferra, Kurt Mitman, Federica Romei
> *Journal of International Economics* **124**, 103303 (2020)
> DOI: [10.1016/j.jinteco.2020.103303](https://doi.org/10.1016/j.jinteco.2020.103303)

The model is a **HANKSOME** (Heterogeneous-Agent New-Keynesian Small Open Model Economy)
calibrated to Hungary. It studies how household portfolio composition and
foreign-currency borrowing amplify a current account reversal (sudden stop).

REMARK author: **Siying Li** (Johns Hopkins University)

---

## AI Navigation Quick Reference

| AI Task | Where to go | Key files |
|---------|-------------|-----------|
| Understand the model | `010_PAPER_ABSTRACT_AND_CLAIMS.md` | Abstract, main findings |
| Navigate the code | `060_CODE_NAVIGATION.md` | Notebook map, data flow |
| Run computations | `030_COMPUTATIONAL_WORKFLOWS.md` | Commands, runtimes |
| Check math | `040_MATHEMATICAL_STRUCTURE.md` | Equations, notation |
| Troubleshoot | `080_TROUBLESHOOTING_FOR_AI_SYSTEMS.md` | Common errors |

---

## Repository at a Glance

```
de-Ferra2020-kz/
├── deFerra2020.tex / .pdf        # Main paper (LaTeX + compiled PDF)
├── reproduce_min.sh              # Build PDF in <30s
├── reproduce.sh --comp full      # Reproduce all figures (~35 min)
├── Code/
│   ├── Python/notebooks/         # 14 Jupyter notebooks (main pipeline)
│   │   ├── 01–04                 # Phase A: Markov, grids, shock, Fig 1
│   │   ├── 05–08                 # Phase B: EGM, distribution, β-calib, Tab 1
│   │   ├── 09–11                 # Phase C: Steady states, transition, Figs 2-3
│   │   └── 12–14                 # Phase D: Unexpected contraction, Figs 4-5
│   └── MATLAB/                   # Original MATLAB package (reference)
├── Figures/                      # PNG figures consumed by LaTeX
└── README_IF_YOU_ARE_AN_AI/      # This directory
```

---

## Key Quantitative Results

| Result | Value | Source |
|--------|-------|--------|
| Discount factor β | ~0.9444 | Notebook 07, Table 1 |
| Asset-to-income ratio | 3.11 | Table 1 (target) |
| Figure 1: credit-supply shock path | 15 periods | Notebook 04 |
| Figure 2: consumption drop, flex FX, impact | ~−15% | Notebook 11 |
| Figure 3: welfare comparison (approx.) | fixed > flex | Notebook 11 |
| Figure 4: consumption impact, contraction | ~−20% flex, ~−15% fixed | Notebook 14 |
| Figure 5: output impact | +5% flex, −3% fixed | Notebook 14 |

---

## Quick Start for AI Systems

### "How do I run the full pipeline?"

```bash
# Requires: Python 3.12, Jupyter, kernel 'deferra2020-kz'
cd Code/Python
./run_all.sh --phase=all        # All phases A-D (~35 min)
./run_all.sh --phase=ABC        # Phases A-C only (~5 min)
./run_all.sh --phase=D          # Phase D only (needs ABC outputs)
```

### "What does each notebook do?"

See `060_CODE_NAVIGATION.md` for a detailed table.

### "I got a convergence error in notebook 13"

See `080_TROUBLESHOOTING_FOR_AI_SYSTEMS.md`.

### "What are the main paper claims?"

See `010_PAPER_ABSTRACT_AND_CLAIMS.md`.
