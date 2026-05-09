# de-Ferra2020-kz Code Architecture

This is the architecture document for the de-Ferra2020-kz REMARK, a reproduction
of **de Ferra, Mitman, and Romei (2020), "Household heterogeneity and the
transmission of foreign shocks," Journal of International Economics 124, 103303**.

---

## Repository Structure

```
de-Ferra2020-kz/
│
├── deFerra2020.tex           # Main LaTeX document (paper)
├── deFerra2020.pdf           # Compiled PDF (primary REMARK artefact)
├── deFerra2020.bib           # Bibliography
├── deFerra2020-Abstract.txt  # Abstract (plain text)
│
├── Subfiles/                 # LaTeX subfile sections
│   ├── Intro.tex
│   ├── literature.tex
│   ├── Model.tex
│   ├── Parameterization.tex
│   ├── Comparing-policies.tex  ← Figs 4-5 embedded here
│   ├── HANK.tex              # "Inspecting the mechanism" section
│   └── Conclusion.tex
│
├── Figures/                  # Figures used by LaTeX
│   ├── deFerra2020_fig1_credit_supply.png
│   ├── deFerra2020_fig2.png
│   ├── deFerra2020_fig3.png
│   ├── deFerra2020_fig4.png
│   └── deFerra2020_fig5.png
│
├── Tables/
│   └── deFerra2020_tab1_calibration.tex   # Table 1 LaTeX fragment
│
├── Code/
│   ├── Python/               # Python reproduction pipeline (primary)
│   │   ├── README.md         # Pipeline docs, setup, runtimes
│   │   ├── run_all.sh        # Execute all notebooks
│   │   ├── output/           # .npz artefacts and PNGs
│   │   └── notebooks/
│   │       ├── 01_rouwenhorst.ipynb
│   │       ├── 02_params_and_grids.ipynb
│   │       ├── 03_shock_path.ipynb
│   │       ├── 04_figure1.ipynb
│   │       ├── 05_egm.ipynb
│   │       ├── 06_distribution.ipynb
│   │       ├── 07_calibrate_beta.ipynb
│   │       ├── 08_verify_table1.ipynb
│   │       ├── 09_initial_ss.ipynb
│   │       ├── 10_solve_transition.ipynb
│   │       ├── 11_figures_2_3.ipynb
│   │       ├── 12_contraction_flex.ipynb
│   │       ├── 13_contraction_fixed.ipynb
│   │       └── 14_figures_4_5.ipynb
│   │
│   └── MATLAB/               # Original MATLAB replication package
│       ├── Main.m
│       ├── MIT_transition.m
│       ├── solve_transition_bis.m
│       ├── solve_transition_fixed.m
│       ├── Figures.m
│       └── Steady_State_Ayagari/
│
├── reproduce.sh              # Main reproduction script (entry point)
├── reproduce_min.sh          # Minimal reproduction (PDF only, <30s)
├── reproduce/                # Supporting scripts
│   ├── README.md
│   ├── reproduce_computed.sh       # Python pipeline dispatcher (--comp)
│   ├── reproduce_computed_min.sh   # Phase A-C only (--comp min)
│   └── reproduce_documents.sh      # LaTeX compilation
│
├── binder/environment.yml    # Conda environment spec
├── CITATION.cff              # Software citation metadata
├── .zenodo.json              # Zenodo deposit metadata
├── README.md                 # Main documentation
├── REMARK.md                 # REMARK tier metadata
├── ARCHITECTURE.md           # This file
└── README_IF_YOU_ARE_AN_AI/  # AI navigation guide for this repo
```

---

## Computation Pipeline (Phase structure)

| Phase | Notebooks | Content | Runtime |
|-------|-----------|---------|---------|
| A | 01–04 | Rouwenhorst chain, parameter grids, shock path, Figure 1 | ~1 min |
| B | 05–08 | EGM, stationary distribution, β-calibration, Table 1 | ~1 min |
| C | 09–11 | Initial & final steady state, credit-expansion transition, Figs 2–3 | ~2 min |
| D | 12–14 | Unexpected contraction (flex + fixed FX), Figs 4–5 | ~25 min |

All phases together: ~26 min on an Apple M4 Pro MacBook Pro (16 GB RAM).

### Data flow

```
01 → 02 → 03 → 04      (markov.npz, params.npz, shock_path.npz)
               ↓
     05 → 06 → 07 → 08  (egm_ss.npz, distribution_ss.npz, calibration.npz)
               ↓
          09 → 10 → 11  (initial_ss.npz, transition_flex.npz)
               ↓
     12 → 13 → 14       (contraction_flex.npz, contraction_fixed.npz)
```

---

## Key Python Modules and Classes

All computation is self-contained in the notebooks; there are no separate `.py`
modules. Key algorithmic components (all implemented inline):

| Concept | Notebooks | Key functions |
|---------|-----------|---------------|
| Rouwenhorst discretisation | 01 | `rouwenhorst()` |
| EGM (Endogenous Grid Method) | 05, 10, 12, 13 | `backsolve_egm()` |
| Stationary distribution | 06 | sparse eigenvector via `scipy.sparse.linalg.eigs` |
| β-calibration | 07 | `scipy.optimize.brentq` |
| Credit-expansion transition | 10 | `scipy.optimize.fsolve` (399-unknown system) |
| Flex-FX contraction | 12 | `scipy.optimize.fsolve` (399-unknown system) |
| Fixed-FX contraction | 13 | `scipy.optimize.root(method='lm')` (599-unknown) |

---

## Reproducing Results

```bash
# Minimal: build PDF from existing figure PNGs (< 30 s)
./reproduce_min.sh

# Regenerate Figs 1-3 + Table 1 from scratch (~5 min)
./reproduce.sh --comp min

# Regenerate all figures including Figs 4-5 (~35 min)
./reproduce.sh --comp full

# Then rebuild the PDF
./reproduce.sh --docs
```

---

## Environment

- Python 3.12
- Key packages: `numpy>=1.26`, `scipy>=1.11`, `matplotlib>=3.8`, `jupyter`
- TeX: TeX Live (full) or MiKTeX

See `binder/environment.yml` and `Code/Python/README.md` for full setup.
