module Correlations

using LinearAlgebra
using ..Model

"""
    three_point_function(x, y, z, d, α, regime)

Computes the probability P(x ↔ y ↔ z) based on the regime.
- LR_LD: Coincides up-to-constants with a Möbius-covariant function.
- LR_CD: Includes logarithmic corrections.
"""
function three_point_function(x::Vector{T}, y::Vector{T}, z::Vector{T}, d::Int, α::Real) where T <: Real
    regime = Model.get_regime(d, α)
    
    # Distances between the three points
    rxy = norm(x - y)
    ryz = norm(y - z)
    rzx = norm(z - x)
    
    if regime == :LR_LD
        # Möbius-covariant form: S(x,y,z)^(-(d-α)/2) 
        # where S is the product of distances.
        power = -(d - α) / 2
        return (rxy * ryz * rzx)^power
        
    elseif regime == :LR_CD
        # Critical dimension d=3α 
        # Includes a 1/sqrt(log) correction factor
        min_dist = min(rxy, ryz, rzx)
        numerator = (rxy * ryz * rzx)^(-(d - α) / 2)
        correction = 1 / sqrt(log(1 + min_dist))
        return numerator * correction
        
    else
        # Standard mean-field bound for LR_HD
        return (rxy * ryz * rzx)^(-α)
    end
end

"""
    two_point_function_correction(r, d, α)

For d = 3α, the two-point function has a sqrt(log r) correction:
P(0 ↔ x) ≈ ||x||^(-d+α) * (log ||x||)^(1/2) 
"""
function two_point_function_correction(r::Real, d::Int, α::Real)
    if d == 3*α
        return r^(-d + α) * sqrt(log(1 + r))
    else
        return r^(-d + α)
    end
end

export three_point_function, two_point_function_correction

end # module
