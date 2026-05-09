# Python reproduction of de Ferra, Mitman, and Romei (2020)

A Python port of selected parts of the original MATLAB replication package
(`Code/MATLAB/`, the [HANKSOME repository](https://github.com/kurtmitman/HANKSOME)
by de Ferra, Mitman, and Romei), focusing on the pieces this REMARK reproduces.

## Scope

| MATLAB source | Python target | Notebook | Status |
|---|---|---|---|
| `Exogenous_files/rouwenhorst.m` | Rouwenhorst AR(1) discretisation | `notebooks/01_rouwenhorst.ipynb` | Phase A |
| `Main.m` lines 27–90 | Structural parameters + steady-state targets | `notebooks/02_params_and_grids.ipynb` | Phase A |
| `Main.m` lines 92–160 | Curved asset grid construction | `notebooks/02_params_and_grids.ipynb` | Phase A |
| `Main.m` lines 268–280 + `MIT_transition.m` line 132 | AR(1) credit-supply shock paths | `notebooks/03_shock_path.ipynb` | Phase A |
| `Figures.m` lines 22–43 | Figure 1 (foreign credit supply) | `notebooks/04_figure1.ipynb` | Phase A |
| `Steady_State_Ayagari/solve_EGM_EL_open_tg.m` | EGM household solver | `notebooks/05_egm.ipynb` | Phase B |
| `Steady_State_Ayagari/ComputeDistHist_open.m` | Stationary distribution | `notebooks/06_distribution.ipynb` | Phase B |
| `Steady_State_Ayagari/calibrate_beta_open_tg.m` | β-calibration outer loop | `notebooks/07_calibrate_beta.ipynb` | Phase B |
| Paper Table 1 + B-suite outputs | Paper / MATLAB / Python comparison table | `notebooks/08_verify_table1.ipynb` | Phase B |
| `Steady_State_Ayagari/calibrate_R_open_tg.m`, `solve_R.m` + `Main.m` lines 229–288 | Initial **and** final SS (zero NFA / AR(1) limit) | `notebooks/09_initial_ss.ipynb` | Phase C |
| `Transition/solve_transition_bis.m` (flex+foreign) + `Transition/backsolve_egm.m` | Credit-supply transition system | `notebooks/10_solve_transition.ipynb` | Phase C |
| `Figures.m` lines 45–195 | Figures 2 and 3 (real allocations + prices) | `notebooks/11_figures_2_3.ipynb` | Phase C |
| `MIT_transition.m` lines 127–157 (contraction) + `Main.m` §Leverage | Unexpected contraction, flex FX, leverage 1/16 | `notebooks/12_contraction_flex.ipynb` | Phase D |
| `Transition/solve_transition_fixed.m` | Unexpected contraction, fixed FX, leverage 1/16 | `notebooks/13_contraction_fixed.ipynb` | Phase D |
| `Figures.m` lines 220–382 | Figures 4 and 5 (flex vs fixed) | `notebooks/14_figures_4_5.ipynb` | Phase D |

## How to run

**Option A — one command, end to end** (recommended for reproducing
everything):

```bash
cd Code/Python
./run_all.sh                    # full pipeline (Phases A+B+C+D), ~30–35 min
./run_all.sh --phase=ABC --fast # < 1 min: Phases A–C only, no fsolve refinement
./run_all.sh --phase=ABC        # ~3–5 min: Phases A–C only
./run_all.sh --phase=D          # ~25 min: Phase D only (assumes ABC has run)
```

`run_all.sh` prints per-notebook wall-clock times and a final pipeline total.
Each notebook also instruments its long-running solvers with
`time.perf_counter()` so individual residual-eval and `fsolve`/`root` durations
are reported in the cell outputs.

**Option B — interactive, cell-by-cell** (recommended for inspection):

```bash
# From the repo root
.venv-darwin-arm64/bin/jupyter lab Code/Python/notebooks/
```

Notebooks 09–11 depend on the outputs of 02–07, and 11 depends on 09–10.
Notebooks 12–14 (Phase D) depend on 02–07 and 09–10 (the period-41
distribution from notebook 10). Each notebook saves its outputs to
`Code/Python/output/` as `.npz` (intermediate state) or `.png` (figures).
Figures 4 and 5 are written to both `Code/Python/output/` and the repo-level
`Figures/` directory so the LaTeX paper picks them up.

### Jupyter kernel: “Python version … no longer supported” (Cursor)

The repo standard is **Python 3.12** (`binder/environment.yml`). Each notebook’s
metadata uses the kernel name `deferra2020-kz` (“de-Ferra 2020 (Python 3.12)”).

If Cursor shows a warning even though cells run:

1. Use **Kernel → Select Kernel** and pick the interpreter that is actually
   **3.12** (e.g. a conda env from `conda env create -f binder/environment.yml`,
   or your registered `deferra2020-kz` ipykernel).
2. Avoid the generic **Python 3.9** (or other EOL) interpreters that ship with
   some IDE defaults; Cursor flags those as unsupported.
3. The warning is **IDE policy**, not a sign that the notebook is wrong: if
   `python -c "import sys; print(sys.version)"` in the selected kernel prints
   3.12.x, you are aligned with the REMARK environment.

Notebook 10's `REFINE = True` flag controls whether `scipy.optimize.fsolve`
is run on the MATLAB warm-start path. With `REFINE=False`, the warm start
is used directly (residual ≤ 1.2e-4); with `True`, residual is driven to
~7e-14 at a cost of ~150 s.

## Phase C dependencies

```
09_initial_ss   ←  02 (params), 03 (shock TT), 06/07 (calibrated SS for d_s/θ*)
10_solve_transition   ←  09 (initial+final SS), 03 (shock_b_agg), Code/MATLAB/transition_start.mat
11_figures_2_3   ←  09 (initial SS aggregates), 10 (transition paths)
```

## Phase D dependencies

```
12_contraction_flex   ←  02, 03 (new_shock_b_agg), 07 (cpol_calibrated), 09, 10 (dist_at_shock_start)
13_contraction_fixed  ←  same as 12, plus 12 (warm start for LM)
14_figures_4_5        ←  10 (expansion baselines), 12, 13
```

## Per-notebook measured runtimes (Apple M-class single-core, May 2026)

These are end-to-end `run_all.sh` wall-clock times measured on this machine (the
`finished in Xs` lines printed by `run_all.sh`):

| Notebook | Wall clock | Notes |
|---|---|---|
| 01 rouwenhorst | 3 s | nbconvert overhead dominates |
| 02 params + grids | 2 s |  |
| 03 shock_path | 2 s |  |
| 04 figure 1 | 2 s | matplotlib |
| 05 EGM | 3 s | inner SS solver |
| 06 distribution | 2 s | sparse eigenvector |
| 07 calibrate β | 12 s | brentq over inner SS solver |
| 08 verify table 1 | 1 s | markdown formatting |
| 09 initial+final SS | 16 s | two brentq solves |
| 10 transition (REFINE=True) | 170 s | warm-start eval + `fsolve` polish |
| 10 transition (REFINE=False, `--fast`) | ~5 s | warm-start only, residual ~1.2e-4 |
| 11 figs 2–3 | 2 s | matplotlib |
| 12 contraction flex | 327 s = 5.4 min | `fsolve`, 399 unknowns, ~812 evals |
| 13 contraction fixed | 1185 s = 19.7 min | LM root, 599 unknowns, ~3000 evals |
| 14 figs 4–5 | < 1 s | matplotlib |
| **Phase A+B+C** total | **~ 3.6 min** | (refinement enabled) |
| **Phase A+B+C** total `--fast` | **< 1 min** | |
| **Phase D** total | **~ 25 min** | |
| **Full pipeline** | **~ 28–30 min** | |

The largest single cost is notebook 13's Levenberg–Marquardt root-find for the
fixed-FX contraction (599 unknowns × 0.4 s per residual × ~5 LM iterations ≈
20 minutes). MATLAB's parallel `fsolve` with `UseParallel=true` is roughly an
order of magnitude faster on the same hardware; we accept the single-core
Python cost in exchange for an open-source dependency tree.

## Conventions

- Inline `# unresolved: …` comments mark places where the Python deviates
  from the MATLAB or where a paper detail still needs to be checked
  (mirroring the prof-preferred convention from
  [econ-ark/ballpark CONTRIBUTING.md](https://github.com/econ-ark/ballpark/blob/master/CONTRIBUTING.md)).
- Each MATLAB-port cell has a markdown header that cites the source file
  and line range (e.g. `Main.m:268–280`).
- Variable names follow the MATLAB convention (`params.alpha`, `Agrid`,
  `shock_b_agg`, …) so cross-checking is easy.

## Out of scope

- Section 7 policy experiments (optimal monetary rules, pegged-but-revisable,
  etc.): would require a re-implementation of the HANKSOME model under
  `HARK` / `sequence-jacobian` to enable fast policy iteration.

Any `Code/Python/notebooks/_dev_*.py` files are scratchpads used during
development; the canonical sources are the `.ipynb` files.
