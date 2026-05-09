# de-Ferra2020-kz Quick Reference

## One-Line Minimal Reproduction (PDF only, < 30s)
```bash
./reproduce_min.sh
```

## Key Commands

| Goal | Command | Time |
|------|---------|------|
| Build PDF from existing figures | `./reproduce_min.sh` | <30s |
| Reproduce Figs 1–3 + Table 1 | `./reproduce.sh --comp min` | ~5 min |
| Reproduce ALL Figs 1–5 | `./reproduce.sh --comp full` | ~35 min |
| Rebuild PDF after compute | `./reproduce.sh --docs` | <30s |
| Check environment | `./reproduce.sh --envt` | ~1 min |
| Run pipeline directly | `cd Code/Python && ./run_all.sh --phase=all` | ~35 min |

## Output Files

```
Code/Python/output/
├── calibration_summary.json    # β, K/Y, r_ss, MPC
├── verification_table.md       # Table 1 comparison vs paper
├── markov.npz                  # Rouwenhorst chain
├── calibration.npz             # Calibrated parameters
├── transition_flex.npz         # Credit-expansion transition
├── contraction_flex.npz        # Unexpected contraction, flex FX
├── contraction_fixed.npz       # Unexpected contraction, fixed FX
└── deFerra2020_fig{1-5}.png    # Figures

Figures/                        # Copies used by LaTeX
└── deFerra2020_fig{1-5}.png
```

## Paper Reference

de Ferra, S., Mitman, K., and Romei, F. (2020).
"Household heterogeneity and the transmission of foreign shocks."
*Journal of International Economics* **124**, 103303.
https://doi.org/10.1016/j.jinteco.2020.103303
