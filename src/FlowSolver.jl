module FlowSolver

using ..Model

"""
    susceptibility_flow(r, E_K, α, β)

Implements the first-order differential equation for susceptibility growth:
d/dr E_r|K| ≈ β * r^(-α-1) * (E_r|K|)^2
This describes how cluster sizes 'blow up' as the observation scale r increases.
"""
function susceptibility_flow(r::Real, E_K::Real, α::Real, β::Real)
    # The growth rate is proportional to the square of the current volume 
    # weighted by the edge probability density at scale r.
    return β * r^(-α - 1) * E_K^2
end

"""
    solve_critical_flow(r_max, α, β; steps=1000)

Simple Euler integration of the susceptibility flow to visualize 
the 'blow-up' near criticality.
"""
function solve_critical_flow(r_max::Real, α::Real, β::Real; steps=1000)
    dr = r_max / steps
    rs = range(1.0, stop=r_max, length=steps)
    volumes = zeros(steps)
    volumes[1] = 1.0 # Initial volume at unit scale
    
    for i in 1:(steps-1)
        dv = susceptibility_flow(rs[i], volumes[i], α, β)
        volumes[i+1] = volumes[i] + dv * dr
    end
    return rs, volumes
end

export susceptibility_flow, solve_critical_flow

end # module
