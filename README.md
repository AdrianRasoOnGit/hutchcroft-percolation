# HutchcroftPercolation.jl

A Julia toolkit for the non-perturbative analysis of critical long-range Bernoulli bond percolation, based on the 2025 trilogy by Tom Hutchcroft.

## Overview
This library implements the real-space renormalization group (RG) framework and regime classification described in:
1. **Part I: High effective dimension** (arXiv:2508.18807)
2. **Part II: Low effective dimension** (arXiv:2508.18808)
3. **Part III: The upper critical dimension** (arXiv:2508.18809)

## Key Features
- **Phase Mapping:** Automatically classify any $(d, \alpha)$ pair into one of the 8 conjectured regimes.
- **Critical Exponents:** Access exact values for $\eta, \gamma, \delta,$ and fractal dimensions $d_f$ across effectively long-range regimes.
- **RG Flow Solver:** Numerical implementation of differential inequalities for susceptibility growth.
- **Möbius Covariance:** Implementation of the $k$-point functions proved for the LR-LD regime.
- **Log-Corrections:** Precise scaling factors for the upper critical dimension $d=3\alpha < 6$.

## Quick Start
```julia
using HutchcroftPercolation

# Identify the regime for a 3D lattice with alpha=1.0
regime = classify_regime(3, 1.0) # Returns "LR-CD (Upper Critical Dim)"

# Get theoretical metadata
meta = get_metadata(3, 1.0)
println("Scaling Limit: ", meta.scaling_limit)
