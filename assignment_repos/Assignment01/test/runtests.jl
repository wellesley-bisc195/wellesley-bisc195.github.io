using Assignment01
using Test

@testset "Assignment01" begin

@testset "Question 1" begin
    @test question1 isa AbstractString
    @test isdefined(Assignment01, :my_name)
    @test isdefined(Assignment01, :my_age)
    @test !occursin("kevin", lowercase(Assignment01.my_name))
    @test Assignment01.my_age < 30
    include("../src/run.jl")
    @test my_name == Assignment01.my_name
    @test my_age == Assignment01.my_age
    @test isnothing(main())
    @test lowercase(question1) == "yes"
end

@testset "Question 2" begin
    @test question2 isa AbstractString

    scmd = string.(split(question2))
    @test first(scmd) == "ls"

    push!(scmd, normpath(joinpath(@__DIR__, "..")))
    dircontents = split(read(Cmd(scmd), String), '\n')
    @test ".git" in dircontents
    @test length(dircontents) > 10
end

@testset "Question 3" begin
    rm("q3", force=true)
    @test question3 isa AbstractString
    scmd = string.(split(question3))
    @test first(scmd) == "mkdir"
    @test length(scmd) == 2
    run(Cmd(scmd))
    @test isdir("q3")
    rm("q3", force=true)
end

@testset "Question 4" begin
    @test question4 isa Real
    @test question4 == 3
end

@testset "Question 5" begin
    @test question4 isa Float64
    @test 0 < question4 < 1
    @test question4 ≈ 7//10
end

end # testset Assignment01