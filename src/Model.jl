module Model

using LinearAlgebra

"""
    edge_probability(x, y, α, β; p=2)

Calculates the probability of a bond existing between points x and y in Z^d.
Formula: 1 - exp(-β * ||x - y||^(-d - α))
"""
function edge_probability(x::Vector{T}, y::Vector{T}, α::Real, β::Real; p=2) where T <: Real
    d = length(x)
    dist = norm(x - y, p)
    dist == 0 && return 0.0
    return 1 - exp(-β * dist^(-d - α))
end

"""
    effective_dimension(d, α)

Calculates the effective dimension d_eff = max{d, 2d/α}.
The model's behavior changes based on whether d_eff > 6 (high-dimensional),
d_eff < 6 (low-dimensional), or d_eff = 6 (upper critical dimension).
"""
function effective_dimension(d::Int, α::Real)
    return max(d, 2d/α)
end

"""
    get_regime(d, α)

Categorizes the model into one of the key regimes identified in the papers:
- :LR_HD (Long-Range High-Dimensional): d > 3α
- :LR_LD (Long-Range Low-Dimensional): d/3 < α < αc(d)
- :LR_CD (Long-Range Critical Dimensional): d = 3α < 6
"""
function get_regime(d::Int, α::Real)
    if d > 3α
        return :LR_HD
    elseif d == 3α && d < 6
        return :LR_CD
    elseif d < 3α # This simplifies the complex LR-LD/SR-LD boundary
        return :LR_LD
    else
        return :SR_Regime # Short-range or borderline cases
    end
end

export edge_probability, effective_dimension, get_regime

end # module
