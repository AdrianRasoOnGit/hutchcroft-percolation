module Exponents

using ..Model

"""
    critical_exponents(d, α)

Returns a dictionary of critical exponents based on the regime.
Note: αc(d) is non-trivial to compute for 2 < d < 6 and is treated 
axiomatically in the papers.
"""
function critical_exponents(d::Int, α::Real)
    regime = Model.get_regime(d, α)
    
    if regime == :LR_HD
        # Mean-field scaling (Paper I)
        return (
            η = 2 - α,
            γ = 1.0,
            δ = 2.0,
            df = 2α, # Typical large cluster size in box of radius R scales as R^2α
            description = "Mean-field behavior, high effective dimension"
        )
    elseif regime == :LR_LD
        # Hyperscaling relations (Paper II)
        # η = 2 - α is predicted to "stick" to this value throughout the LR regime
        return (
            η = 2 - α,
            γ = α / (d - α/2), # Derived from hyperscaling if ν is known
            δ = (d + α) / (d - α),
            df = (d + α) / 2,
            description = "Low-dimensional behavior, hyperscaling holds"
        )
    elseif regime == :LR_CD
        # Critical Dimension (Paper III)
        # Characterized by logarithmic corrections to mean-field
        return (
            η = 2 - α,
            tail_exponent = 0.5, # P(|K| >= n) ~ n^-1/2 with log corrections
            log_correction = 0.25, # (log n)^1/4 factor
            description = "Upper critical dimension d=3α < 6"
        )
    else
        return "Regime not explicitly covered by the 2025 trilogy constants."
    end
end

export critical_exponents

end # module
