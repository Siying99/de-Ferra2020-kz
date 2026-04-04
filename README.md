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

## Template

This repository was created from the [HAFiscal-Public](https://github.com/llorracc/HAFiscal-Public) template and restructured for the de Ferra et al. (2020) paper.

---

## References

- de Ferra, S., Mitman, K., & Romei, F. (2020). Household heterogeneity and the transmission of foreign shocks. *Journal of International Economics*, 124, 103303. https://doi.org/10.1016/j.jinteco.2020.103303

- Carroll, C. D. (2024). *Solving Microeconomic Dynamic Stochastic Optimization Problems*. https://llorracc.github.io/SolvingMicroDSOPs/
