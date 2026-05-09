# de Ferra, Mitman, and Romei (2020) — REMARK

[![Powered by Econ-ARK](https://img.shields.io/badge/Powered%20by-Econ--ARK-blue)](https://econ-ark.org)

**Paper**: [Household heterogeneity and the transmission of foreign shocks](https://doi.org/10.1016/j.jinteco.2020.103303)
**Authors**: Sergio de Ferra, Kurt Mitman, Federica Romei
**Journal**: *Journal of International Economics*, 124, 103303, 2020.

**REMARK author**: Siying Li, Johns Hopkins University
**REMARK tier**: 2 (baseline / standard)

---

## Overview

This REMARK reproduces the model and calibration of de Ferra, Mitman, and Romei (2020), and adds a modular stage decomposition of the household Bellman equation.

The paper builds a Heterogeneous-Agent New-Keynesian Small Open Model Economy (HANKSOME) that studies how household-level heterogeneity — particularly portfolio composition and foreign-currency borrowing — shapes the transmission of foreign shocks during current account reversals. The model is calibrated to Hungary going into the Global Financial Crisis.

The REMARK contains two kinds of reproducible content:

1. **A LaTeX paper (`deFerra2020.tex` → `deFerra2020.pdf`)** summarising the paper's model, calibration (Table 1), and core intuition. The PDF is the *primary* reproducible artefact and is built by `./reproduce.sh --docs` or `./reproduce_min.sh`.

2. **A supplementary Jupyter notebook (`deFerra2020_bellman-stages.ipynb`)** that decomposes the household Bellman equation into modular DDSL stages (discounting, shocks-only, consumption). This notebook is expository (markdown-only); it does not execute computational code.

---

## What this REMARK reproduces

| Paper object | Status in REMARK | Location |
|---|---|---|
| Model environment and Bellman equation | Summarised in paper §3 | `Subfiles/Model.tex` |
| Calibration (Table 1, all 13 parameters) | **Reproduced verbatim** | `Tables/deFerra2020_tab1_calibration.tex`, `Code/Python/notebooks/02–08` |
| Calibration narrative (§4.1.1–4.1.5) | **Reproduced as paraphrase** | `Subfiles/Parameterization.tex` |
| β-calibration & SS asset-market clearing | **Reproduced from scratch in Python** | `Code/Python/notebooks/05–07` |
| Figure 1 (credit supply shock) | **Reproduced from scratch in Python** | `Code/Python/output/deFerra2020_fig1_credit_supply.png` |
| Initial / final SS (zero NFA & AR(1) limit) | **Reproduced from scratch in Python** | `Code/Python/notebooks/09_initial_ss.ipynb` |
| Credit-supply transition (perfect-foresight) | **Reproduced from scratch in Python** | `Code/Python/notebooks/10_solve_transition.ipynb` |
| Figures 2 & 3 (real allocations + prices) | **Reproduced from scratch in Python** | `Code/Python/output/deFerra2020_fig{2,3}.png` |
| Figures 4 & 5 (unexpected contraction, flex vs fixed FX) | **Reproduced from scratch in Python** | `Figures/deFerra2020_fig{4,5}.png` |
| Quantitative policy experiments (§7) | Not reproduced | — |
| Stage decomposition of household problem | **Added** as supplementary exposition | `deFerra2020_bellman-stages.ipynb` |

The REMARK targets **Tier 2** of the econ-ark [REMARK standard](https://github.com/econ-ark/REMARK/blob/main/STANDARD.md): the calibration and core model are reproducible from a clean clone, the metadata is complete (`CITATION.cff`, `REMARK.md`, `codemeta.json`, `schema.json`), and the build is documented. Tier 3 (archival with Zenodo DOI) is out of scope.

---

## Quick start

```bash
# Clone and enter the repo
git clone https://github.com/Siying99/de-Ferra2020-kz.git
cd de-Ferra2020-kz

# Build the PDF only (≤1 minute, no Python required)
./reproduce_min.sh

# Run the fast Python pipeline (Table 1 + Figs 1–3, ≈ 5 min)
./reproduce.sh --comp min

# Run the full Python pipeline (everything, including Figs 4–5, ≈ 30 min)
./reproduce.sh --comp full

# Full help (all options, runtime estimates, environment setup)
./reproduce.sh --help
```

| Command | What it does | Runtime |
|---|---|---|
| `./reproduce_min.sh` | Build `deFerra2020.pdf` from existing figures | ≤ 1 min |
| `./reproduce.sh --docs` | Same as above (REMARK convention) | ≤ 1 min |
| `./reproduce.sh --comp min` | Phases A–C: Rouwenhorst, EGM, β-calibration, Figs 1–3 | ~5 min |
| `./reproduce.sh --comp full` | Phases A–D: everything above + sudden-stop Figs 4–5 | ~30 min |

Runtimes are measured on a 2024 MacBook Pro M3, single-core. The Python pipeline prints per-notebook wall-clock times via `time.perf_counter()`, and `reproduce.sh` prints quantitative results (calibrated $\beta^\star$, $K/Y$, NFA/Y, residuals) directly to the terminal at the end of `--comp min`.

---

## Repository contents

### Primary artefacts

| Path | What it is |
|---|---|
| `deFerra2020.tex` | Main LaTeX source (econark class) |
| `deFerra2020.pdf` | Compiled paper — the main reproduction output |
| `deFerra2020_bellman-stages.ipynb` | Supplementary stage-decomposition notebook |
| `deFerra2020.bib` | Bibliography |

### Subfiles

The paper is assembled from `\subfile`'d sections under `Subfiles/`:

- `Intro.tex`, `literature.tex`, `Model.tex`, `Parameterization.tex`, `Comparing-policies.tex`, `HANK.tex`, `Conclusion.tex`

### Tables & figures

- `Tables/deFerra2020_tab1_calibration.tex` — reproduces the paper's Table 1 (full calibration, all 13 parameters).
- `Figures/deFerra2020_fig1_credit_supply.png` — reproduces Figure 1 of the paper.
- `Figures/deFerra2020_fig{2,3,4,5}.png` — reproduce Figures 2–5 of the paper.

### REMARK metadata

- `CITATION.cff`, `REMARK.md`, `codemeta.json`, `schema.json`

### Reproduction scaffolding

- `reproduce.sh`, `reproduce_min.sh` — build entry points.
- `binder/environment.yml`, `binder/requirements.txt`, `pyproject.toml`, `Dockerfile` — Python 3.12 environment definitions.
- `.latexmkrc`, `@resources/`, `@local/` — LaTeX build configuration and vendored TeX packages (including the `econark.bst` bibliography style).

---

## Calibration summary

The model is solved at a quarterly frequency and calibrated to Hungary going into the 2008 financial crisis. The 13 calibrated parameters are reproduced verbatim in `Tables/deFerra2020_tab1_calibration.tex`. Highlights:

- **Preferences**: CRRA over a CES home/foreign aggregator; $\sigma = 1$, $\chi = 0.6$, $\beta = 0.983$.
- **Labor productivity**: AR(1) with $\rho_{l} = 0.97$, $\sigma_{l} = 0.2$; discretised via Rouwenhorst.
- **Trade elasticities**: macro elasticity $\theta = 1$ (home), micro elasticity $\theta^{*} = 3$ (foreign), following Feenstra et al.\ (2018).
- **Foreign credit**: $\bar B = -2$ quarters of GDP, matching Hungary's 2008 net-foreign-asset position.
- **Nominal rigidities**: $\varepsilon = 10$, $\zeta = 100$ (Rotemberg), slope of NKPC $= 0.1$.

See `Subfiles/Parameterization.tex` for the narrative §4.1.1–4.1.5 and `Tables/deFerra2020_tab1_calibration.tex` for the compact table.

---

## Environment

The Python environment is standardised across `binder/environment.yml`, `binder/requirements.txt`, `pyproject.toml`, and `Dockerfile` at **Python 3.12** with modern scientific-stack pins (`numpy>=1.26`, `scipy>=1.11`, `pandas>=2.1`, `numba>=0.59`, etc.). This environment is required for the 14 computational notebooks under `Code/Python/notebooks/` (which reproduce Figures 1–5 and the Table 1 calibration); the supplementary Bellman-stages notebook is markdown-only and does not require the Python environment to read.

The LaTeX build uses the `econark` document class and bibliography style, both vendored in `@resources/texlive/texmf-local/`. The project `.latexmkrc` sets `TEXINPUTS` and `BSTINPUTS` so that `latexmk`/`bibtex` find these files without any extra environment setup.

---

## Stage decomposition (notebook)

The notebook `deFerra2020_bellman-stages.ipynb` walks through:

1. The paper's household problem in its original monolithic form: a single Bellman equation that jointly handles shock realisation, consumption choice, and inter-temporal discounting.
2. A decomposition into three sequential stages using the DDSL (Discrete Decision Stage Lifecycle) convention from *SolvingMicroDSOPs*:

   ```
   a_t → [shocks-only]  →  m̌_t  →  [cons-noshocks]  →  ψ_t  →  [disc]  →  exit
   ```

   - **shocks-only**: idiosyncratic productivity and aggregate shocks realise; portfolio is revalued; normalised market resources $\check m_t$ are computed.
   - **cons-noshocks**: consumption is chosen, yielding post-consumption (end-of-period-before-discounting) wealth $\psi_t$.
   - **disc**: inter-temporal discounting and deterministic accumulation to $a_{t+1}$.

3. Stage-level perch tables explicitly listing state variables, continuation values, and normalisations.
4. A discussion of how this decomposition connects the model to the Endogenous Grid Method (EGM): the `shocks-only → cons-noshocks` ordering lets the consumption first-order condition be inverted directly without an inner expectation loop.
5. A path toward an executable implementation within the Econ-ARK `HARK` framework.

The notebook is intentionally markdown-only: its purpose is to clarify the timing and the mapping to DDSL, not to solve the model numerically. A future version of this REMARK could add an executable stage-by-stage solver.

---

## Python reproduction (steady state, calibration, transitions, Figs 1–5)

A modular Python reproduction lives under `Code/Python/` and runs end-to-end as
14 numbered Jupyter notebooks (`01_rouwenhorst.ipynb` → `14_figures_4_5.ipynb`).
See [`Code/Python/README.md`](Code/Python/README.md) for the dependency graph and
[`Code/Python/output/verification_table.md`](Code/Python/output/verification_table.md)
for a paper / MATLAB / Python comparison table covering Table 1 and the impact-
period magnitudes of Figures 2–5.

Highlights of the from-scratch Python ports:

- **Phase A**: Rouwenhorst chain, parameter+grid construction, AR(1) credit-supply
  paths, Figure 1 (notebooks 01–04).
- **Phase B**: EGM, stationary distribution, β-calibration, Table 1 verification
  (notebooks 05–08). Calibrates `β* = 0.98322`, asset-market residual `~1.5e-4`.
- **Phase C**: initial+final steady states, perfect-foresight credit-supply
  transition with foreign-currency-debt revaluation, and Figures 2 & 3
  (notebooks 09–11). Transition residual is driven to `~7e-14` after a one-shot
  `scipy.optimize.fsolve` polish on the MATLAB warm-start path.
- **Phase D**: unexpected credit contraction (sudden stop) at t = 41, with
  leverage $\hat k = 1/16$. Notebook 12 solves the **flexible-FX** transition
  (`fsolve` over 399 unknowns, ~5 min, residual $\sim 10^{-8}$). Notebook 13
  ports `solve_transition_fixed.m` and solves the **fixed-FX** transition with a
  Levenberg–Marquardt root-finder over 599 unknowns (~20 min, residual
  $\sim 10^{-13}$). Notebook 14 reproduces Figures 4 & 5 comparing the two
  regimes side-by-side.

Per-notebook wall-clock timings are printed by each notebook (via
`time.perf_counter()`), and a total-pipeline timer is built into
`Code/Python/run_all.sh`. Single-core wall-clock budget on Apple-silicon laptops
(May 2026):

- `./run_all.sh --phase=ABC --fast`: **< 1 min**
- `./run_all.sh --phase=ABC`: **~3–5 min**
- `./run_all.sh --phase=all` (everything): **~30–35 min** (Phase D dominates)

The MATLAB sources are vendored under `Code/MATLAB/` (the original [HANKSOME
package](https://github.com/kurtmitman/HANKSOME) by de Ferra, Mitman, and
Romei) for cross-checking and for the `Code/MATLAB/transition_start.mat`
warm-start used by notebook 10.

## Known limitations / future work

- The §7 policy experiments (optimal monetary rules, pegged-but-revisable
  exchange rates) are not replicated. A faithful replication would require
  embedding the HANKSOME solver inside an outer Ramsey-planner loop, which is
  natural to do under the `HARK` / `sequence-jacobian` stack and is a
  promising direction for future work.
- The Bellman-stages notebook (`deFerra2020_bellman-stages.ipynb`) is currently
  expository (markdown only). A future version of the REMARK could promote
  this to an executable stage-by-stage solver in HARK.

---

## Template credit

This repository was scaffolded from [HAFiscal-Public](https://github.com/llorracc/HAFiscal-Public) (Carroll, Crawley, Du, Frankovic, and Tretvoll). All HAFiscal-specific code, data, tables, and documentation have been removed; the surviving infrastructure (`reproduce.sh`, `@resources/`, the `econark` LaTeX class) has been adapted to the de Ferra (2020) project.

---

## References

- de Ferra, S., Mitman, K., & Romei, F. (2020). Household heterogeneity and the transmission of foreign shocks. *Journal of International Economics*, 124, 103303. https://doi.org/10.1016/j.jinteco.2020.103303
- Carroll, C. D. (2024). *Solving Microeconomic Dynamic Stochastic Optimization Problems*. https://llorracc.github.io/SolvingMicroDSOPs/
- Feenstra, R. C., Luck, P., Obstfeld, M., & Russ, K. N. (2018). In search of the Armington elasticity. *Review of Economics and Statistics*, 100(1), 135–150.
- Kaplan, G., Moll, B., & Violante, G. L. (2018). Monetary policy according to HANK. *American Economic Review*, 108(3), 697–743.

---

## License

Apache-2.0. See `LICENSE` for details.
