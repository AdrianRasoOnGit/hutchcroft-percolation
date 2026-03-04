module PhaseDiagram

"""
    classify_regime(d, α; η_sr=0.0)

Classifies the model into one of the 8 regimes:
1. LR-HD: Long-Range High-Dimensional (d > 3α)
2. LR-LD: Long-Range Low-Dimensional (d/3 < α < α_c)
3. LR-CD: Long-Range Critical-Dimensional (d = 3α < 6)
4. SR-HD: Short-Range High-Dimensional (d > 6, α > 2)
5. SR-LD: Short-Range Low-Dimensional (d < 6, α > α_c)
6. SR-CD: Short-Range Critical-Dimensional (d = 6, α > 2)
7. mSR-HD: Marginal Short-Range High-Dimensional (α = 2, d ≥ 6)
8. mSR-LD: Marginal Short-Range Low-Dimensional (α = α_c, d < 6)
"""
function classify_regime(d::Int, α::Real; η_sr::Real=0.0)
    α_c = 2 - η_sr # Crossover value 
    
    # Effectively Long-Range
    if α < α_c
        if d > 3*α
            return "LR-HD (Mean-field)"
        elseif d == 3*α && d < 6
            return "LR-CD (Upper Critical Dim)"
        else
            return "LR-LD (Hyperscaling)"
        end
    # Effectively Short-Range
    else
        if d > 6
            return α == 2 ? "mSR-HD" : "SR-HD"
        elseif d == 6
            return "SR-CD"
        else
            return α == α_c ? "mSR-LD" : "SR-LD"
        end
    end
end

export classify_regime

end # module
