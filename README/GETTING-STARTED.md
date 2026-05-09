# Getting Started with de-Ferra2020-kz

**Welcome!** This guide helps you reproduce the results of the REMARK for
**de Ferra, Mitman, and Romei (2020), "Household heterogeneity and the transmission
of foreign shocks," *Journal of International Economics* 124, 103303.**

---

## What do you want to do?

### Just read the paper PDF (< 30 seconds)
```bash
open deFerra2020.pdf        # it's already there
# or rebuild from LaTeX:
./reproduce_min.sh
```

### Reproduce Figures 1–3 and Table 1 (~5 min)
```bash
./reproduce.sh --comp min   # runs notebooks 01–11
./reproduce.sh --docs       # rebuilds the PDF
```

### Reproduce ALL figures including 4 and 5 (~35 min)
```bash
./reproduce.sh --comp full  # runs notebooks 01–14
./reproduce.sh --docs
```

---

## Requirements

- **Python 3.12** with packages in `binder/environment.yml`
- **Jupyter kernel** named `deferra2020-kz`:
  ```bash
  python -m ipykernel install --user --name deferra2020-kz \
      --display-name "Python (deferra2020-kz)"
  ```
- **TeX Live** (for PDF compilation)

See `Code/Python/README.md` for full setup details.

---

## What gets reproduced?

| Artefact | Notebook | Phase | Time |
|----------|----------|-------|------|
| Table 1 (calibration) | 07–08 | B | ~30s |
| Figure 1 (credit supply) | 04 | A | ~5s |
| Figures 2–3 (expansion transition) | 11 | C | ~3 min total |
| Figures 4–5 (contraction, flex vs fixed FX) | 14 | D | ~25 min |

---

## Where are the outputs?

| Output | Location |
|--------|----------|
| Computed arrays | `Code/Python/output/*.npz` |
| Calibration summary | `Code/Python/output/calibration_summary.json` |
| Figures (PNG) | `Code/Python/output/` and `Figures/` |
| Verification table | `Code/Python/output/verification_table.md` |
| Compiled paper | `deFerra2020.pdf` |
