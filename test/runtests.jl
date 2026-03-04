using HutchcroftPercolation
using Test

@testset "HutchcroftPercolation.jl" begin
    @testset "Regime Logic" begin
        # Test the critical dimension d=3α boundary
        @test classify_regime(3, 1.0) == "LR-CD (Upper Critical Dim)"
        # Test mean-field
        @test classify_regime(4, 1.0) == "LR-HD (Mean-field)"
    end
    
    @testset "Correlations" begin
        # Simple check for scaling factor logic
        @test three_point_function([0.0], [1.0], [2.0], 1, 0.5) > 0
    end
end
