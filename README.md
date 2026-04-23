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
| Calibration (Table 1, all 13 parameters) | **Reproduced verbatim** | `Tables/deFerra2020_tab1_calibration.tex` |
| Calibration narrative (§4.1.1–4.1.5) | **Reproduced as paraphrase** | `Subfiles/Parameterization.tex` |
| Figure 1 (credit supply shock) | **Reproduced** as an image | `Figures/deFerra2020_fig1_credit_supply.png` |
| Impulse responses (Figs. 2–5, 7, 8) | Not reproduced | — |
| Quantitative policy experiments (§7) | Not reproduced | — |
| Stage decomposition of household problem | **Added** as supplementary exposition | `deFerra2020_bellman-stages.ipynb` |

The REMARK targets **Tier 2** of the econ-ark [REMARK standard](https://github.com/econ-ark/REMARK/blob/main/STANDARD.md): the calibration and core model are reproducible from a clean clone, the metadata is complete (`CITATION.cff`, `REMARK.md`, `codemeta.json`, `schema.json`), and the build is documented. Tier 3 (archival with Zenodo DOI) is out of scope.

---

## Quick start

```bash
# Clone and enter the repo
git clone https://github.com/Siying99/de-Ferra2020-kz.git
cd de-Ferra2020-kz

# Minimal reproduction (builds deFerra2020.pdf, ~1 minute)
./reproduce_min.sh

# Full help / other options
./reproduce.sh --help
```

On a 2024 MacBook Pro M3 (16 GB RAM), the minimal PDF build takes ~30–60 seconds.

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
- `Figures/HANK_*.tex` — *placeholder* files inherited from the template; they do not render in the main PDF.

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

The Python environment is standardised across `binder/environment.yml`, `binder/requirements.txt`, `pyproject.toml`, and `Dockerfile` at **Python 3.12** with modern scientific-stack pins (`numpy>=1.26`, `scipy>=1.11`, `pandas>=2.1`, etc.). The notebook is markdown-only, so the Python environment is only needed if you want to launch Jupyter to read the notebook interactively.

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

## Known limitations / future work

- The quantitative experiments of the paper (§6–§7) are not replicated here; a faithful replication would require a new Python implementation of the HANKSOME solver under the `HARK` / `sequence-jacobian` stack.
- Some filenames in `Figures/` and elsewhere inherited from the HAFiscal template still have `HANK` in them. They are hollow placeholders and are not included in the main PDF build.
- The `--comp` and `--data` branches of `reproduce.sh` are template scaffolding and reference the HAFiscal computational code under `Code/HA-Models/`; they should not be run against the de Ferra 2020 model.

---

## Template credit

This repository was scaffolded from [HAFiscal-Public](https://github.com/llorracc/HAFiscal-Public) (Carroll, Crawley, Du, Frankovic, and Tretvoll). HAFiscal-specific code, tables, and appendix content have been removed or replaced with de Ferra-appropriate content; some filenames with `HANK` in them are retained as template scaffolding and contain placeholder notices.

---

## References

- de Ferra, S., Mitman, K., & Romei, F. (2020). Household heterogeneity and the transmission of foreign shocks. *Journal of International Economics*, 124, 103303. https://doi.org/10.1016/j.jinteco.2020.103303
- Carroll, C. D. (2024). *Solving Microeconomic Dynamic Stochastic Optimization Problems*. https://llorracc.github.io/SolvingMicroDSOPs/
- Feenstra, R. C., Luck, P., Obstfeld, M., & Russ, K. N. (2018). In search of the Armington elasticity. *Review of Economics and Statistics*, 100(1), 135–150.
- Kaplan, G., Moll, B., & Violante, G. L. (2018). Monetary policy according to HANK. *American Economic Review*, 108(3), 697–743.

---

## License

Apache-2.0. See `LICENSE` for details.
