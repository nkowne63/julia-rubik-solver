using Revise
using Test
using rubikSolver

@testset "rubikSolver.jl" begin
    # Write your tests here.
    @test rubikSolver.greet() == "test str2"
end
