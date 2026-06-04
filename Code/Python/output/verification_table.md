# Verification table

Cross-check of de Ferra–Mitman–Romei (2020) Table 1 against our independent Python pipeline.


| Group | Parameter / Quantity | Paper | MATLAB | **Python** | Source |
|---|---|---|---|---|---|
| Preferences | $\sigma$ (CRRA) | 1.0 | 1.0 | **1.000** | paper §4.1.1; Main.m:32 |
| Preferences | $\theta$ (intratemporal EOS) | 1.0 | 1.0 | **1.000** | paper §4.1.1; Main.m:33 |
| Preferences | $\chi = 1 - \omega$ (home-goods share) | 0.6 | 0.6 | **0.600** | paper §4.1.1; Main.m:35 |
| Preferences | $\varphi$ (Frisch) | 0.5 (paper Table 1 footnote) | 0.5 | **0.500** | paper §4.1.1; Main.m:39 |
| Preferences | $\beta$ (discount factor) | 0.983 | 0.9832 (warm start) → calibrated | **0.98322** | paper §4.1.1; Main.m:215, calibrate_beta_open_tg.m |
| Productivity | $\rho_l$ (AR(1) persistence) | 0.97 | 0.97 | **0.970** | paper §4.1.2; Main.m:48 |
| Productivity | $\sigma_l$ (cross-sectional std) | 0.84 | 0.84 | **0.840** | paper §4.1.2; Main.m:50 |
| Productivity | Implied 1-step autocorr (verification) | 0.97 (target) | 0.97 | **0.970000** | notebook 01 (Rouwenhorst exactness) |
| Productivity | Implied cross-sectional std (verification) | 0.84 (target) | 0.84 | **0.840000** | notebook 01 |
| Technology | $\alpha$ (capital share) | 0.33 | 0.33 | **0.330** | paper §4.1.3; Main.m:31 |
| Technology | $\delta$ (quarterly depreciation) | 0.02 | 0.02 (= 0.08/4) | **0.0200** | paper §4.1.3; Main.m:34 |
| Technology | $K/Y$ (quarterly capital-output ratio) | 9.70 | 9.703 (= cap_gdp) | **9.7028** | paper §4.1.3; Main.m:64, derived |
| Foreign sector | $\bar B / Y$ (NFA / quarterly GDP) | -2.0 (paper text §4.1.4) | -1.418 (per-capita MATLAB) | **-1.4182** | paper §4.1.4; Main.m:19, 79 |
| Foreign sector | $\theta^{*}$ (foreign demand elasticity) | 3.0 (FLOR 2018) | computed endogenously per Main.m:254 | **3** (raw 2.595) | paper §4.1.4; Main.m:254; notebook 09 |
| Nominal rigidities | $\varepsilon$ (intra-domestic EOS) | 10.0 | 10.0 | **10.0** | paper §4.1.5; Main.m:40-41 |
| Nominal rigidities | $\zeta$ (Rotemberg adj cost) | 100.0 | 100.0 | **100.0** | paper §4.1.5; Main.m:42 |
| Nominal rigidities | NKPC slope ($\varepsilon/\zeta$) | 0.10 | 0.10 | **0.100** | paper §4.1.5; derived |
| **— Derived equilibrium quantities —** | | | | | |
| Steady state | $r_{ss}$ (quarterly real rate) | ~1.0% / quarter | 0.01061 | **0.01061** | derived from Main.m:71 |
| Steady state | $r_{ss}$ annualised | ~4% / year | ~4.32% | **4.3120%** | derived |
| Steady state | $A^{HH}$ (asset demand) | $K + B$ | $K + B$ | **25.3721** | notebook 06 (eigenvector of T) |
| Steady state | Asset-market residual | 0.0 (calibrated) | ~0.0 | **-1.55e-04** | notebook 07 (brentq) |
| Steady state | Aggregate MPC (quarterly) | — (not in paper Table 1) | 0.109 | **0.1087** | notebook 06 (PCHIP derivative of $c(a)$) |

## Notes

- **`β`**: paper Table 1 reports 0.983; MATLAB uses 0.9832 as a warm-start guess (`Main.m` line 203) and then runs `fsolve` over `calibrate_beta_open_tg.m` (line 215). Our Python brentq calibration converges to `β* = 0.98322`, which differs from 0.983 by `0.00022`.
- **`K/Y`**: target value 9.703 from `target.cap_gdp` (Main.m line 21); our calibrated SS produces 9.7028 to within numerical tolerance.
- **`NFA/Y`**: paper text §4.1.4 quotes `-2.0` but the MATLAB calibration computes `-1.418` from per-capita Eurostat / HFCS numbers (Main.m lines 18-19, 22). We use the MATLAB value verbatim.
- **`θ*` (foreign demand elasticity)**: paper text quotes 3.0; the MATLAB *computes* `theta_star` endogenously in `Main.m` line 254 (`ceil(...)`) to clear an asset-market identity. Phase C notebook 09 reproduces this: the raw value is `2.594818` and `ceil(·) = 3`, matching the paper, with `d_s = 1.01495`. The integer `θ* = 3` is then carried into the transition (notebook 10 via `initial_ss.npz`).
- **MPC**: not a calibration target in the paper; reported here as a model-implied moment (~11% per quarter / ~37% annual).
