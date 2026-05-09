# Final course-project submission — May 12, 2026

**Course:** Advanced Macro, Johns Hopkins University, Spring 2026
**Author:** Siying Li
**Project:** REMARK reproducing de Ferra, Mitman, and Romei (2020), *Household Heterogeneity and the Transmission of Foreign Shocks*, *Journal of International Economics*, 124, 103303.

**Repository:** <https://github.com/Siying99/de-Ferra2020-kz>
**Tagged release:** [`v1.0.0`](https://github.com/Siying99/de-Ferra2020-kz/releases/tag/v1.0.0)

---

## What this submission is

The final state of `main` (incorporating PRs #1–#5) is the course-project artefact. This file documents the submission and clarifies which earlier deliverable was for which assignment.

| Assignment | Deliverable | Status |
|---|---|---|
| **Class 12 / #141** — *Ask AI help to improve your REMARK* (due Apr 23, 2026) | [PR #1: *Substance improvements from Claude Opus 4.7 review*](https://github.com/Siying99/de-Ferra2020-kz/pull/1) — implemented all 10 substantive improvements from a Claude Opus 4.7 baseline-REMARK review. Prompt + full model response + accept/edit/reject judgments are in the PR body and the [linked gist](https://gist.github.com/Siying99/745b844792c8e836447aeed2430cd16a). | Merged Apr 23, 2026 |
| **Final course project** (due May 12, 2026) | This PR + the final state of `main`. Extends PRs #2–#5 beyond the original Task 2 scope. | This PR |

---

## What is reproduced (final-project scope)

| Paper object | Status | Code path |
|---|---|---|
| Table 1 calibration (13 parameters) | Reproduced from scratch in Python | `Tables/deFerra2020_tab1_calibration.tex`, `Code/Python/notebooks/02–08` |
| Calibrated discount factor β | β\* = 0.98322 (paper: 0.983, residual 2.2 × 10⁻⁴) | `Code/Python/notebooks/07_calibrate_beta.ipynb` |
| Figure 1 (foreign credit-supply paths) | Reproduced from scratch in Python | `Figures/deFerra2020_fig1_credit_supply.png` |
| Figures 2–3 (credit-expansion transition) | Reproduced from scratch; transition residual ≈ 7 × 10⁻¹⁴ | `Figures/deFerra2020_fig{2,3}.png` |
| Figures 4–5 (sudden-stop, flexible vs. fixed FX) | Reproduced from scratch; residuals ≈ 10⁻⁸ (flex) / 10⁻¹³ (fixed) | `Figures/deFerra2020_fig{4,5}.png` |
| §7 policy experiments | Out of scope; flagged in `README.md` *Known limitations* | — |
| Stage decomposition of household Bellman equation (DDSL convention) | **Original to this REMARK** — supplementary pedagogical contribution | `deFerra2020_bellman-stages.ipynb` |

A side-by-side paper / MATLAB / Python comparison table for the impact-period magnitudes of Figures 2–5 lives at `Code/Python/output/verification_table.md`.

---

## How to reproduce

```bash
git clone https://github.com/Siying99/de-Ferra2020-kz.git
cd de-Ferra2020-kz
git checkout v1.0.0   # or: git checkout main

./reproduce.sh --docs        # Compile deFerra2020.pdf only            (≤ 1 min)
./reproduce.sh --comp min    # Phases A–C: calibration + Figs 1–3      (≈ 5 min)
./reproduce.sh --comp full   # Phases A–D: full pipeline incl. Figs 4–5 (≈ 30 min)
./reproduce.sh --help        # All options + per-phase runtime estimates
```

Runtimes measured on an Apple M4 Pro MacBook Pro, single-core. The Python pipeline prints per-notebook wall-clock times via `time.perf_counter()`, and `reproduce.sh --comp min` prints quantitative results (β\*, K/Y, NFA/Y, residuals) at the end.

---

## REMARK Tier-2 compliance checklist

Verified against [`econ-ark/REMARK/STANDARD.md`](https://github.com/econ-ark/REMARK/blob/master/STANDARD.md):

- [x] Tagged release (`v1.0.0`) on `main` HEAD with semantic versioning + GitHub release notes
- [x] `Dockerfile` in repository root
- [x] `reproduce.sh` (full reproduction) and `reproduce_min.sh` (fast PDF-only)
- [x] `LICENSE` (Apache-2.0)
- [x] `binder/environment.yml` (Python 3.12, pinned)
- [x] `README.md` ≥ 100 non-empty lines (currently 158)
- [x] `REMARK.md` with `tier: 2` front-matter
- [x] Valid `CITATION.cff` (CFF 1.2.0)

---

## Acknowledgements

This repository was scaffolded from [HAFiscal-Public](https://github.com/llorracc/HAFiscal-Public) (Carroll, Crawley, Du, Frankovic, and Tretvoll). All HAFiscal-specific code, data, tables, and documentation have been removed; only generic infrastructure (`reproduce.sh`, the `econark` LaTeX class, vendored TeX packages) survives, adapted to the de Ferra (2020) project.

The MATLAB sources under `Code/MATLAB/` are vendored from the [HANKSOME package](https://github.com/kurtmitman/HANKSOME) by Kurt Mitman, used here as the reference implementation against which the Python pipeline is cross-validated.
