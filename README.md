# de Ferra, Mitman, and Romei (2020) — Bellman Stage Decomposition

[![Powered by Econ-ARK](https://img.shields.io/badge/Powered%20by-Econ--ARK-blue)](https://econ-ark.org)

**Paper**: [Household heterogeneity and the transmission of foreign shocks](https://doi.org/10.1016/j.jinteco.2020.103303)
**Authors**: Sergio de Ferra, Kurt Mitman, Federica Romei
**Journal**: *Journal of International Economics*, 124, 103303, 2020.

---

## Overview

This REMARK explores the household optimization problem in de Ferra, Mitman, and Romei (2020). The paper builds a Heterogeneous-Agent New-Keynesian Small Open Model Economy (HANKSOME) to study how household heterogeneity—particularly portfolio composition and foreign-currency borrowing—shapes the transmission of foreign shocks during current account reversals.

The main contribution of this REMARK is a **stage decomposition** of the household's Bellman equation following the DDSL (Discrete Decision Stage Lifecycle) framework from [SolvingMicroDSOPs](https://llorracc.github.io/SolvingMicroDSOPs/). The decomposition breaks the monolithic Bellman equation into modular stages (discounting, shocks-only, consumption), clarifying the timing of shocks and decisions and connecting the model to the Endogenous Grid Method (EGM).

---

## Quick Start

### Docker (Recommended)

```bash
docker build -t de-ferra2020-kz .
docker run --rm -it de-ferra2020-kz
```

### Native Installation

```bash
conda env create -f binder/environment.yml
conda activate hafiscal
./reproduce.sh --docs main
```

Or, with [UV](https://docs.astral.sh/uv/) (faster):

```bash
uv sync --all-groups
source .venv-$(uname -s | tr '[:upper:]' '[:lower:]')-$(uname -m)/bin/activate
./reproduce.sh --docs main
```

---

## Notebook

- **[deFerra2020_bellman-stages.ipynb](deFerra2020_bellman-stages.ipynb)** — The main notebook containing:
  1. The paper's model and household Bellman equation
  2. Stage decomposition into disc / shocks-only / cons-noshocks stages
  3. Stage tables with perch definitions and value function mappings
  4. Comparison with the monolithic formulation
  5. Discussion of normalization for the EGM and path toward implementation

---

## Key Ideas

- **HANKSOME model**: Households hold nominal asset portfolios across domestic bonds, foreign-currency bonds, capital, and real bonds. An unexpected exchange rate change revalues foreign-currency debt, generating heterogeneous wealth effects.

- **Stage decomposition**: The household's period is decomposed as:

  ```
  a → [shocks-only] → m̌ → [cons-noshocks] → ψ → [disc] → exit
  ```

  where shocks realize first (determining market resources), then consumption is chosen, then discounting is applied.

- **EGM connection**: The shocksonly–consnoshocks ordering allows the consumption FOC to be inverted directly via the EGM, avoiding inner expectation loops.

---

## Reproduction Instructions

The `reproduce.sh` script provides multiple reproduction options:

```bash
./reproduce.sh --help               # Full documentation
./reproduce.sh --envt               # Test environment setup
./reproduce.sh --docs main          # Compile the paper (LaTeX)
./reproduce.sh --docs all           # Compile paper + figures + tables + subfiles
./reproduce.sh --comp min           # Minimal computational results (~1 hour)
./reproduce.sh --comp full          # Full computational results (4–5 days)
./reproduce.sh --all                # Everything: computation + documents
```

A minimal reproduction script is also provided:

```bash
./reproduce_min.sh                  # Delegates to ./reproduce.sh --comp min
```

---

## Repository Structure

```
.
├── Dockerfile                      # Docker environment definition
├── reproduce.sh                    # Main reproduction script
├── reproduce_min.sh                # Minimal reproduction (REMARK compliance)
├── README.md                       # This file
├── REMARK.md                       # REMARK catalog metadata
├── CITATION.cff                    # Citation metadata (CFF format)
├── LICENSE                         # Apache 2.0
├── binder/
│   └── environment.yml             # Conda environment specification
├── deFerra2020_bellman-stages.ipynb # Main Jupyter notebook
├── deFerra2020.tex                 # LaTeX source for the paper
├── deFerra2020.bib                 # BibTeX references
├── Code/
│   └── HA-Models/                  # Computational code (HANK models)
├── Figures/                        # Generated figures (LaTeX)
├── Tables/                         # Generated tables (LaTeX)
├── Subfiles/                       # LaTeX subfiles
├── reproduce/                      # Reproduction helper scripts and logs
└── dashboard/                      # Interactive Voilà dashboard
```

---

## System Requirements

- **Docker**: Version 20.0+ (recommended for full portability)
- **TeX Live**: 2023 or later (for document compilation)
- **Python**: 3.9+ with dependencies in `binder/environment.yml`
- **UV** (optional): For faster Python environment setup

### Tested Platforms

- macOS 14+ (Apple Silicon and Intel)
- Ubuntu 20.04+ (via Docker and native)
- Windows 10+ with WSL2

---

## Template

This repository was created from the [HAFiscal-Public](https://github.com/llorracc/HAFiscal-Public) template and restructured for the de Ferra et al. (2020) paper.

---

## Citation

If you use this code, please cite both this repository and the original paper:

```bibtex
@software{li2025deferra_bellman,
  author       = {Li, Siying},
  title        = {Household Heterogeneity and the Transmission of Foreign
                  Shocks --- Bellman Stage Decomposition},
  year         = {2025},
  publisher    = {GitHub},
  url          = {https://github.com/Siying99/de-Ferra2020-kz}
}

@article{deFerra2020,
  author  = {de Ferra, Sergio and Mitman, Kurt and Romei, Federica},
  title   = {Household heterogeneity and the transmission of foreign shocks},
  journal = {Journal of International Economics},
  volume  = {124},
  pages   = {103303},
  year    = {2020},
  doi     = {10.1016/j.jinteco.2020.103303}
}
```

Or use the `CITATION.cff` file for automatic citation generation on GitHub.

---

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for details.

---

## References

- de Ferra, S., Mitman, K., & Romei, F. (2020). Household heterogeneity and the transmission of foreign shocks. *Journal of International Economics*, 124, 103303. https://doi.org/10.1016/j.jinteco.2020.103303

- Carroll, C. D. (2024). *Solving Microeconomic Dynamic Stochastic Optimization Problems*. https://llorracc.github.io/SolvingMicroDSOPs/
