# Code Directory

This directory contains all computational code for reproducing the results in de Ferra, Mitman, and Romei (2020), "Household Heterogeneity and the Transmission of Foreign Shocks," *Journal of International Economics*, 124, 103303.

## Structure

```
Code/
├── Python/          # Python reproduction pipeline (primary)
│   ├── notebooks/   # 14 Jupyter notebooks (Phases A–D)
│   ├── output/      # Generated figures, calibration, and verification files
│   ├── README.md    # Full pipeline documentation with runtimes
│   └── run_all.sh   # Orchestration script
└── MATLAB/          # Original MATLAB code from the paper's authors
    ├── Main.m       # Entry point: calibration + transition
    ├── Figures.m    # Figure generation
    ├── MIT_transition.m
    ├── Steady_State_Ayagari/
    ├── Transition/
    └── Exogenous_files/
```

## Python Pipeline

The Python code (`Code/Python/`) reproduces Figures 1–5 and the Table 1 calibration from scratch using only open-source Python libraries (NumPy, SciPy, Matplotlib). See `Code/Python/README.md` for the full pipeline description, phase breakdown, and runtime estimates.

**Quick start:**
```bash
cd Code/Python
KERNEL=deferra2020-kz ./run_all.sh --phase=all   # ~30 min, all phases
KERNEL=deferra2020-kz ./run_all.sh --phase=ABC   # ~5 min, Figs 1–3 + calibration
```

## MATLAB Code

The `Code/MATLAB/` directory contains the original MATLAB code shared by the paper's authors. It is included as the authoritative reference for the numerical algorithms. The Python pipeline cross-validates its output against the MATLAB results; see `Code/Python/output/verification_table.md`.

To run the MATLAB code, open `Main.m` and execute from the `Code/MATLAB/` directory with MATLAB R2020a or later.
