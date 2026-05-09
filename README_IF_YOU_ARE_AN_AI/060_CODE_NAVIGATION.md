# Code Navigation — de-Ferra2020-kz

## Primary Pipeline: Code/Python/notebooks/

All results are produced by running notebooks in order. Each notebook saves `.npz`
files to `Code/Python/output/` that later notebooks read.

### Notebook Map

| Notebook | Phase | Input(s) | Output(s) | Runtime |
|----------|-------|----------|-----------|---------|
| `01_rouwenhorst.ipynb` | A | — | `markov.npz` | <5s |
| `02_params_and_grids.ipynb` | A | — | `params.npz` | <5s |
| `03_shock_path.ipynb` | A | `markov.npz`, `params.npz` | `shock_path.npz` | <5s |
| `04_figure1.ipynb` | A | `shock_path.npz` | `deFerra2020_fig1*.png` | <5s |
| `05_egm.ipynb` | B | `params.npz`, `markov.npz` | `egm_ss.npz` | ~10s |
| `06_distribution.ipynb` | B | `egm_ss.npz` | `distribution_ss.npz` | ~5s |
| `07_calibrate_beta.ipynb` | B | `params.npz`, `markov.npz` | `calibration.npz`, `calibration_summary.json` | ~20s |
| `08_verify_table1.ipynb` | B | `calibration.npz` | `verification_table.md` | <5s |
| `09_initial_ss.ipynb` | C | `calibration.npz` | `initial_ss.npz` | ~10s |
| `10_solve_transition.ipynb` | C | `initial_ss.npz`, `shock_path.npz` | `transition_flex.npz` | ~2min |
| `11_figures_2_3.ipynb` | C | `transition_flex.npz` | `deFerra2020_fig{2,3}.png` | <5s |
| `12_contraction_flex.ipynb` | D | `transition_flex.npz` | `contraction_flex.npz` | ~5min |
| `13_contraction_fixed.ipynb` | D | `contraction_flex.npz` | `contraction_fixed.npz` | ~20min |
| `14_figures_4_5.ipynb` | D | `contraction_flex.npz`, `contraction_fixed.npz` | `deFerra2020_fig{4,5}.png` | <5s |

### Running Notebooks

```bash
cd Code/Python
./run_all.sh --phase=ABC        # Phases A-C only (~5 min)
./run_all.sh --phase=D          # Phase D only (requires Phase C outputs)
./run_all.sh --phase=all        # All phases (~35 min)
```

Or run from repo root:
```bash
./reproduce.sh --comp min       # Phase A-C
./reproduce.sh --comp full      # Phase A-D
```

---

## Reference Code: Code/MATLAB/

The original MATLAB replication package from the paper. Key files:

| MATLAB file | Python equivalent |
|-------------|-------------------|
| `Main.m` | `run_all.sh` (orchestrator) |
| `Steady_State_Ayagari/solve_EGM_EL_open_tg.m` | `05_egm.ipynb` |
| `Steady_State_Ayagari/calibrate_beta_open_tg.m` | `07_calibrate_beta.ipynb` |
| `Steady_State_Ayagari/ComputeDistHist_open.m` | `06_distribution.ipynb` |
| `Transition/backsolve_egm.m` | `backsolve_egm()` in notebooks 10, 12, 13 |
| `Transition/solve_transition_bis.m` | `10_solve_transition.ipynb` + `12_contraction_flex.ipynb` |
| `Transition/solve_transition_fixed.m` | `13_contraction_fixed.ipynb` |
| `MIT_transition.m` | `12_contraction_flex.ipynb` + `13_contraction_fixed.ipynb` |
| `Figures.m` | `11_figures_2_3.ipynb` + `14_figures_4_5.ipynb` |

---

## Key Algorithmic Components

### Rouwenhorst Discretisation (nb 01)
Approximates the AR(1) income process with a finite Markov chain.
`rouwenhorst(N, rho, sigma)` → transition matrix + grid.

### Endogenous Grid Method (EGM) (nb 05, 10, 12, 13)
Function `backsolve_egm(a_grid, z_grid, Pi, beta, sigma, r, w)`:
- Iterates on consumption policy function using first-order conditions
- Uses PCHIP interpolation (`scipy.interpolate.PchipInterpolator`)
- Returns savings policy function and consumption function

### Stationary Distribution (nb 06)
Sparse matrix eigenvalue method:
`scipy.sparse.linalg.eigs(T.T, k=1, which='LM', sigma=1.0)`

### β-Calibration (nb 07)
`scipy.optimize.brentq` minimising distance between model asset-to-income ratio
and empirical target (3.11).

### Transition Solver — flexible FX (nb 10, 12)
399-unknown system (TT × 3 − 3), solved with `scipy.optimize.fsolve`.

### Transition Solver — fixed FX (nb 13)
599-unknown system (3 × TT − 1), solved with `scipy.optimize.root(method='lm')`.
Includes backward NKPC iteration for price dynamics.

---

## Output Files

All computed output lives in `Code/Python/output/`:

| File | Contents |
|------|----------|
| `markov.npz` | Rouwenhorst grid + transition matrix |
| `params.npz` | Structural parameters + asset grid |
| `shock_path.npz` | Credit supply shock sequence |
| `egm_ss.npz` | Steady-state policy functions |
| `distribution_ss.npz` | Stationary wealth distribution |
| `calibration.npz` | β-calibration output |
| `calibration_summary.json` | Human-readable summary |
| `initial_ss.npz` | Initial (pre-shock) steady state |
| `transition_flex.npz` | Full expansion transition paths |
| `contraction_flex.npz` | Unexpected contraction, flex FX |
| `contraction_fixed.npz` | Unexpected contraction, fixed FX |
| `verification_table.md` | Numerical verification vs. paper |
| `deFerra2020_fig*.png` | Figure images |

Figures are also copied to `Figures/` in the repo root for use by LaTeX.
