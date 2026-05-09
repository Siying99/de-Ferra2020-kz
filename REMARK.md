---
# Metadata for indexing this REMARK in the econ-ark project
# See https://github.com/econ-ark/REMARK
github_repo_url: https://github.com/Siying99/de-Ferra2020-kz
remark-name: de-Ferra2020-kz
tier: 2
notebooks:
  - deFerra2020_bellman-stages.ipynb
  - Code/Python/notebooks/01_rouwenhorst.ipynb
  - Code/Python/notebooks/02_params_and_grids.ipynb
  - Code/Python/notebooks/03_shock_path.ipynb
  - Code/Python/notebooks/04_figure1.ipynb
  - Code/Python/notebooks/05_egm.ipynb
  - Code/Python/notebooks/06_distribution.ipynb
  - Code/Python/notebooks/07_calibrate_beta.ipynb
  - Code/Python/notebooks/08_verify_table1.ipynb
  - Code/Python/notebooks/09_initial_ss.ipynb
  - Code/Python/notebooks/10_solve_transition.ipynb
  - Code/Python/notebooks/11_figures_2_3.ipynb
  - Code/Python/notebooks/12_contraction_flex.ipynb
  - Code/Python/notebooks/13_contraction_fixed.ipynb
  - Code/Python/notebooks/14_figures_4_5.ipynb
tags:
  - REMARK
  - Notebook
keywords:
  - Heterogeneous Agents
  - Small Open Economy
  - Current Account Reversal
  - Exchange Rate
  - Foreign Currency Debt
  - HANK
---
# Household Heterogeneity and the Transmission of Foreign Shocks

This is a REMARK reproducing the steady-state calibration and credit-supply transition of "Household heterogeneity and the transmission of foreign shocks" by Sergio de Ferra, Kurt Mitman, and Federica Romei (*Journal of International Economics*, 124, 103303, 2020).

## What is reproduced

* **Calibration (Table 1)**: from-scratch Python ports of the Rouwenhorst chain, parameter+grid construction, EGM household solver, stationary distribution, and β-calibration outer loop. Calibrated $\beta^\star = 0.98322$ matches the paper's reported 0.983 to within `2.2e-4`.
* **Figure 1** (foreign credit supply paths): from-scratch Python.
* **Figures 2–3** (credit-expansion transition: real allocations + prices): from-scratch Python ports of `solve_transition_bis.m` (flexible-FX, foreign-currency debt branch) and `backsolve_egm.m`. Transition residual driven to `~7e-14` after a one-shot `scipy.optimize.fsolve` polish on the MATLAB warm-start path.
* **Figures 4–5** (unexpected credit contraction at $t = 41$, leverage $\hat k = 1/16$, flex vs fixed FX): from-scratch Python ports of the contraction branch of `MIT_transition.m` and `solve_transition_fixed.m`. The flex transition is solved with `scipy.optimize.fsolve` (399 unknowns, residual $\sim 10^{-8}$, ~5 min) and the fixed-FX transition with Levenberg–Marquardt (599 unknowns, residual $\sim 10^{-13}$, ~20 min). Each notebook prints its own wall-clock time; `Code/Python/run_all.sh` reports a per-notebook breakdown and a pipeline total.
* **Stage decomposition** of the household Bellman equation into modular DDSL stages (`deFerra2020_bellman-stages.ipynb`) following the convention from [SolvingMicroDSOPs](https://llorracc.github.io/SolvingMicroDSOPs/).

Out of scope: §7 policy experiments (optimal monetary rules, pegged-but-revisable, etc.).

See `Code/Python/README.md` for the dependency graph and `Code/Python/output/verification_table.md` for a paper / MATLAB / Python comparison table.
