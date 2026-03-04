module ScalingLimits

"""
    limit_type(α)

Identifies the specific superprocess scaling limit.
- α < 2: Integrated symmetric α-stable Lévy superprocess excursion.
- α ≥ 2: Super-Brownian motion (Gaussian limit).
"""
function limit_type(α::Real)
    if α < 2
        return "Super-Lévy (Stable)"
    else
        return "Super-Brownian (Gaussian)"
    end
end

"""
    scaling_corrections(d, α)

Returns the slowly-varying corrections needed for the scaling limit.
For d = 3α < 6, logarithmic corrections are required to achieve 
convergence.
"""
function scaling_corrections(d::Int, α::Real)
    if d == 3*α && d < 6
        return "Logarithmic: (log n)^(1/4) for volume tail "
    elseif d > 3*α
        return "None: Clean power-law scaling"
    else
        return "Non-trivial: Hyperscaling regime"
    end
end

export limit_type, scaling_corrections

end # module
