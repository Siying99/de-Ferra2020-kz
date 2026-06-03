# REMARK-improvement review — round 2 (final-project Python pipeline)

This file records a second **"ask AI to improve your REMARK"** pass (course
assignment #141), applying the explicit **accept / edit / reject** discipline to
the parts of the REMARK that the *first* pass never saw.

## Why a second pass

The first pass — [PR #1](https://github.com/Siying99/de-Ferra2020-kz/pull/1)
(*Substance improvements from Claude Opus 4.7 review*, merged Apr 23, 2026) —
reviewed the **April baseline**: the LaTeX paper, the metadata, and the build.
The final course project then added the entire **14-notebook Python
reproduction pipeline** (`Code/Python/`, Figures 1–5, β-calibration, the
credit-supply and sudden-stop transitions). That new substance had not had an
accept/edit/reject improvement pass; this round supplies it.

- **Reviewer / method:** Claude Opus, reviewing the *current* repository against
  the [econ-ark REMARK Tier-2 standard](https://github.com/econ-ark/REMARK/blob/master/STANDARD.md)
  on four axes — reproducibility from a clean clone, model fidelity vs. the
  paper/MATLAB, documentation completeness, and code quality.
- **Discipline:** every finding gets an explicit verdict and a one-line reason;
  rejected items say *why*.

## Findings and verdicts

| # | Axis | Finding (one line) | Verdict | Action taken |
|---|---|---|:--:|---|
| R1 | Reproducibility | Root `environment.yml` still pinned Python **3.9** under `name: hafiscal` (HAFiscal-template orphan); `dashboard/environment.yml` pinned 3.11.7 — while the rest of the repo is 3.12. A `conda env create -f environment.yml` would build an env that cannot run the notebooks. (Regression of PR #1 item 3.) | **accept** | Rewrote root `environment.yml` to the de-Ferra **3.12** env (mirrors `binder/environment.yml`); aligned `dashboard/environment.yml` to 3.12. |
| R2 | Reproducibility | `run_all.sh`'s `nbconvert --inplace` rewrote volatile `iopub.*` execution timestamps into all 14 notebooks every run (→ huge meaningless diffs); saved-path `print`s used `.resolve()`, leaking absolute machine paths into committed output. | **accept (edit)** | Added a post-execution metadata-strip step to `run_all.sh`; replaced the 19 `.resolve()` path-leak prints with relative paths; stripped the existing 85 timestamp blocks so the tracked notebooks are byte-clean. Documented the policy in `Code/Python/README.md`. |
| R3 | Documentation | `verification_table.md` θ\* row read `— (Phase C)`, but Phase C/D are done: notebook 09 computes θ\* = **3** (raw 2.5948). Notebook 08 runs *before* 09, so it never refreshed. | **accept** | Filled the θ\* row (3; raw 2.595, `d_s` = 1.01495) in `verification_table.md` and in notebook 08's table-builder source + note. |
| F1 | Model fidelity | `04_figure1.ipynb` normalised Figure 1 by `y_ss` (a proxy) with an `# unresolved: Phase B will replace this` comment — but Phase C now produces the exact initial-SS output (`initial_ss.npz['y_initial']` = 2.982, vs the proxy 3.0625, ~2.7% off). | **accept** | Notebook 04 now loads the exact initial-SS `y` (graceful fallback to the proxy if outputs are wiped); regenerated Figure 1 and synced it into `Figures/`. |
| R4 | Fidelity / docs | Notebook 10's markdown said *"Default is `REFINE = False`"* while the code sets `REFINE = True`; and the `--fast` (`REFINE=False`) path is warm-started from `transition_start.mat` at residual ~1.2e-4, not independently converged. | **accept (edit)** | Corrected the markdown to match the code and added the honest framing that `--fast` leans on the committed MATLAB warm start. |
| Q1 | Code quality | Shared economic constants (`TT`, `shock_start`, `k̂`, `phi_ac`, `rho_shock`, `cur_acc`) appear as bare literals across notebooks. | **edit (light)** | A full shared-constants refactor is heavy and would fight the notebook design; instead documented their canonical values + the fact they are persisted in `shock_path.npz` and read downstream (`Code/Python/README.md`). |
| R5 | Reproducibility | Committed `output/*.npz` + duplicated figure PNGs are not gitignored; a partial run can read stale artifacts. | **edit (document)** | Kept the committed outputs (they enable the <1-min PDF-only path and `--phase=D`), but documented the rationale and the stale-artifact caveat, and made `run_all.sh` keep `Figures/` Fig 1 in sync. |
| Q2 | Code quality | No shared `.py` solver library; solver code is duplicated across notebooks. | **reject** | Intentional: the notebooks are the pedagogical unit and preserve the line-by-line MATLAB correspondence that is the point of the cross-check. Recorded as future work, with a design note in `Code/Python/README.md`. |
| F2 | Fidelity | NFA/Y = −1.418 (MATLAB per-capita) vs paper text −2.0. | **accept as-is** | Already honestly documented in `verification_table.md` and an `# unresolved:` note; no change. |
| F3 | Fidelity | Notebook 13 clips `dec_temp_fine` where MATLAB errors, and replicates a suspected MATLAB indexing bug for residual parity. | **accept as-is** | Intentional, documented deviations flagged in the notebook's "faithful port" notes; no change. |

## Verification

- All 14 notebooks parse as valid `nbformat` v4; notebook 04 re-executes
  cleanly and prints `y_initial = 2.982035 [initial SS, notebook 09]`.
- `bash -n Code/Python/run_all.sh` passes; the new metadata-strip and Fig 1 sync
  steps are guarded and idempotent.
- All four environment files that mention a Python version now agree on 3.12.
- `verification_table.md` θ\* row now reads **3** (raw 2.595).
