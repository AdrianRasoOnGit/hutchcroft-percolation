module Hydrodynamics

"""
    is_hydrodynamic_condition_met(d, α)

The hydrodynamic condition is a 'marginal triviality' condition. 
It is verified for the critical dimension d = 3α < 6.
"""
function is_hydrodynamic_condition_met(d::Int, α::Real)
    if d == 3*α && d < 6
        return true # Verified in Paper III
    elseif d > 3*α
        return true # High-dimensional regime implicitly satisfies it
    else
        return false # Generally fails in LR-LD regime
    end
end

"""
    median_cluster_size_bound(r, d, α)

Returns the order of the median cluster size Mr in a box of radius r.
- For d=3α, Mr = O(r^((d+α)/2)).
"""
function median_cluster_size_bound(r::Real, d::Int, α::Real)
    # The condition prevents large clusters from merging via a single edge
    # when passing from scale r to 2r.
    return r^((d + α) / 2)
end

"""
    scaling_functions(r, α, regime)

Computes the normalization factors η(r) and ζ(r) for scaling limits.
For d=3α:
- ζ(r) ~ r^(2α) * (log r)^(-1/2)
- η(r) ~ r^(-α) * (log r)^(1/2)
"""
function scaling_factors(r::Real, α::Real, regime::Symbol)
    if regime == :LR_CD
        ζ = r^(2α) * (log(r))^(-0.5)
        η = r^(-α) * (log(r))^(0.5)
        return (ζ=ζ, η=η)
    else
        # Standard power laws for LR-HD
        return (ζ=r^(2α), η=r^(-α))
    end
end

export is_hydrodynamic_condition_met, median_cluster_size_bound, scaling_factors

end # module
