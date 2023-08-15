using Revise
using Test
using rubikSolver

@testset "rubikSolver.jl" begin
    # Write your tests here.
    @test rubikSolver.greet() == "test str2"
end

@testset "rawCube.jl" begin
    using rubikSolver.rawCube:
        x, y, z, right, left, positive, negative, plus, minus, Face, AxisRotation
    @test positive * negative == negative
    @test Face(x, positive) * AxisRotation(x, left) == Face(x, positive)
    @test Face(x, negative) * AxisRotation(z, right) == Face(y, positive)
    @test (x, minus) * AxisRotation(y, right) == (z, minus)
end
