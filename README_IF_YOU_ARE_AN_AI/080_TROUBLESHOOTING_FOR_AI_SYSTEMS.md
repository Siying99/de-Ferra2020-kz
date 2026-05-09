# Troubleshooting Guide — de-Ferra2020-kz

## Common Issues

---

### 1. Kernel not found when running notebooks

**Symptom**: `jupyter nbconvert` fails with "No such kernel 'deferra2020-kz'"

**Fix**:
```bash
python -m ipykernel install --user \
    --name deferra2020-kz \
    --display-name "Python (deferra2020-kz)"
```
Then verify with `jupyter kernelspec list`.

---

### 2. Notebook 13 (fixed-FX contraction) fails with RuntimeError

**Symptom**: `RuntimeError: dec_temp_fine < bmin at t=0` during `backsolve_egm`

**Cause**: The outer `scipy.optimize.root(method='lm')` passes a trial
`(q, tot, NX_share)` vector that leads to negative net wealth, causing
asset decisions to fall below the borrowing limit.

**Fix** (already applied in the notebook): `backsolve_egm` uses
`np.maximum(dec_temp_fine, bmin)` instead of raising a `RuntimeError`.
This gives a smooth residual surface for the solver.

If the error recurs, check that you are not accidentally using an old
version of the `backsolve_egm` function from another notebook.

---

### 3. Notebook 13 does not converge (large residual remains)

**Symptom**: `scipy.optimize.root` status message shows `xtol` not satisfied
or residual > 1e-4 after many iterations.

**Possible causes**:
- Wrong initial guess: re-run notebook 12 first to regenerate `contraction_flex.npz`
- The solver got stuck in a local minimum; try a different `method` (e.g. `hybr`)
- Memory pressure caused NaN in intermediate arrays

**Diagnostic**:
```python
import numpy as np
data = np.load("output/contraction_fixed.npz", allow_pickle=True)
print(data['residual'])  # should be < 1e-5 at solution
```

---

### 4. Figures are blank or missing

**Symptom**: PNG files in `Figures/` exist but are empty or not updated.

**Fix**: Run the relevant notebook again, or check that the notebook
saves to *both* `Code/Python/output/` and `Figures/`:
```python
FIGS_DIR = Path("../../../Figures")   # repo root Figures/
fig.savefig(FIGS_DIR / "deFerra2020_fig4.png", dpi=150, bbox_inches="tight")
```

---

### 5. `latexmk` fails with "file not found"

**Symptom**: LaTeX build fails because a figure PNG is missing.

**Fix**: Run the Python pipeline first:
```bash
./reproduce.sh --comp full    # or --comp min for Figs 1-3 only
./reproduce.sh --docs
```

---

### 6. `run_all.sh --fast` not skipping fsolve in notebook 10

**Symptom**: notebook 10 still runs the full `fsolve` refinement (~170s)
even with `--fast`.

**Cause**: The `sed` pattern in `run_all.sh` that modifies `REFINE = True`
must match the exact JSON string `"REFINE = True\n",`.

**Fix**: Check the `sed` line in `run_all.sh`:
```bash
sed -i.bak 's/"REFINE = True\\n",/"REFINE = False\\n",/g' notebooks/10_solve_transition.ipynb
```

---

### 7. `reproduce.sh --comp min` fails with "kernel not found"

**Fix**: Ensure the `deferra2020-kz` kernel is registered (see issue 1 above).
The `KERNEL` environment variable passed by `reproduce_computed_min.sh` must
match an installed kernel name exactly.

---

## Verification Checklist

After a successful full run, verify:

```bash
# 1. Calibration converged
cat Code/Python/output/calibration_summary.json

# 2. Figures exist
ls Figures/deFerra2020_fig{1,2,3,4,5}.png

# 3. PDF compiled
ls -lh deFerra2020.pdf    # should be > 500 KB

# 4. Numerical comparison
cat Code/Python/output/verification_table.md
```

The calibration summary should show β ≈ 0.944 and asset-to-income ratio ≈ 3.11.
