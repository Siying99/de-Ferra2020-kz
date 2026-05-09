# Paper Abstract and Key Claims — de Ferra, Mitman, Romei (2020)

## Paper Details

**Title:** Household heterogeneity and the transmission of foreign shocks  
**Authors:** Sergio de Ferra, Kurt Mitman, Federica Romei  
**Journal:** *Journal of International Economics* 124, 103303 (2020)  
**DOI:** https://doi.org/10.1016/j.jinteco.2020.103303  

---

## Abstract (verbatim)

We study the role of heterogeneity in the transmission of foreign shocks. We build
a Heterogeneous-Agent New-Keynesian Small Open Model Economy (HANKSOME) that
experiences a current account reversal. Households' portfolio composition and the
extent of foreign currency borrowing are key determinants of the magnitude of the
contraction in consumption associated with a sudden stop in capital inflows. The
contraction is more severe when households are leveraged and owe debt in foreign
currency. In this setting, the revaluation of foreign debt causes a larger
contraction in aggregate consumption when debt and leverage are concentrated among
poorer households. Closing the output gap via an exchange-rate devaluation may
therefore be detrimental to household welfare due to the heterogeneous impact of
the foreign debt revaluation. Our HANKSOME framework can rationalize the observed
"fear of floating" in emerging market economies, even in the absence of
contractionary devaluations.

---

## Key Claims

### Claim 1: Leverage distribution amplifies consumption contractions

> **Statement**: When debt and leverage are concentrated among poorer households
> (those with higher MPCs), a sudden stop causes a larger aggregate consumption
> contraction through the net-wealth channel.

**Mechanism**: Foreign-currency debt revaluation reduces net wealth disproportionately
for leveraged households. Since these households have high MPCs, the aggregate
consumption effect is amplified relative to a representative-agent model.

**Python evidence**: Notebook 12–13 (`contraction_flex.npz`, `contraction_fixed.npz`).

---

### Claim 2: Fixed exchange rates can improve welfare despite causing a recession

> **Statement**: Fixing the exchange rate reduces the foreign-debt revaluation,
> protecting highly-leveraged poor households, and thereby improves aggregate welfare
> in consumption-equivalent terms — even though it generates a deeper output recession.

**Mechanism**: Under flexible FX, depreciation stimulates output (Figure 5, +5% on
impact) but causes a larger consumption crash (Figure 4, ~−20%) because foreign debt
becomes more expensive in domestic terms. Under fixed FX, consumption falls less
(~−15%) at the cost of a GDP recession (~−3%).

**Python evidence**: Notebooks 12–14; Figures 4–5.

---

### Claim 3: Fear of floating is rationalised without contractionary devaluation

> **Statement**: The model generates endogenous "fear of floating" because the
> welfare cost of the debt-revaluation channel exceeds the benefit of the
> output-gap closing channel.

---

## Table 1 — Calibration (Reproduced)

| Parameter | Value | Target |
|-----------|-------|--------|
| Discount factor β | ~0.9444 | Asset-to-income ratio 3.11 |
| CRRA σ | 2.0 | Standard |
| AR(1) income persistence ρ | 0.966 | Storesletten et al. |
| Income shock std dev σ_z | 0.017 | Storesletten et al. |
| Borrowing limit b̲ | −0.525 | Net foreign assets / income |
| World interest rate r* | 0.04 | Annual |
| Steady-state credit b* | 0.375 | Hungary NFA / income |

See `Code/Python/output/calibration_summary.json` for exact values from notebook 07.

---

## Figures Reproduced

| Figure | Content | Notebook | Output file |
|--------|---------|---------|-------------|
| 1 | Credit supply shock path (Markov chain transitions) | 04 | `deFerra2020_fig1_credit_supply.png` |
| 2 | Consumption, assets, distribution — credit expansion | 11 | `deFerra2020_fig2.png` |
| 3 | Welfare decomposition — expansion vs. baseline | 11 | `deFerra2020_fig3.png` |
| 4 | Consumption & key macro vars — unexpected contraction, flex vs. fixed FX | 14 | `deFerra2020_fig4.png` |
| 5 | Output gap & exchange rate — unexpected contraction, flex vs. fixed FX | 14 | `deFerra2020_fig5.png` |
