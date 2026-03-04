module HutchcroftPercolation

using LinearAlgebra, Graphs, StaticArrays

# Load the sub-modules
include("Model.jl")
include("PhaseDiagram.jl")
include("Exponents.jl")
include("Renormalization.jl")
include("Hydrodynamics.jl")
include("FlowSolver.jl")
include("Correlations.jl")
include("ScalingLimits.jl")

# Export the functions you want researchers to use easily
export classify_regime, 
       critical_exponents, 
       limit_type, 
       three_point_function,
       solve_critical_flow,
       is_hydrodynamic_condition_met

end # module
