using Assignment02
using Test
using Random
using Suppressor

@testset "Assignment02" begin

@testset "Setup" begin
    @test isdefined(Assignment02, :generate_sequence)
    Random.seed!(1)
    s = generate_sequence(4)
    @test length(s) == 4
    #@test s == "GGTC"
end

@testset "Question 1" begin
    @test question1 isa DataType
    b = try
        a = question1[]
        push!(a, "test")
    catch e
        println(e)
        a = []
    end
    @test length(b) == 1
end

@testset "Question 2" begin
    @test question2 isa Function
    @test question2("string") isa Bool
    @test question2("string")
    @test question2(1.) isa Bool
    @test !question2(1.)
end

@testset "Question 3" begin
    @test question3 isa Function
    @test question3("AGGC") == 0.75
end

@testset "Question 4" begin
    @test question4 isa Function
    
    out = @capture_out begin question4("ATTC") end
    (ln1,ln2,ln3,ln4) = split(out, '\n')

    @test ln1 == "Sequence:"
    @test ln2 == "ATTC"
    @test ln3 == "GC Content:"
    @test ln4 == "0.25"

    seq = generate_sequence(20)
   
    out = @capture_out begin question4(seq) end
    (ln1,ln2,ln3,ln4) = split(out, '\n')

    @test ln1 == "Sequence:"
    @test ln2 == seq
    @test ln3 == "GC Content:"
    @test ln4 == string((count(==('G'), seq)+count(==('C'), seq)) / 20)
end

@testset "Question 5" begin
    @test Assignment02.ce_2_2_1 isa Bool
    @test !Assignment02.ce_2_2_1 
    @test Assignment02.ce_2_2_2 isa Bool
    @test Assignment02.ce_2_2_2 
    @test Assignment02.ce_2_3_1 isa Float64
    @test isapprox(Assignment02.ce_2_3_1, 4 / 3 * π * 5^2, atol = 1e-2)
    @test Assignment02.ce_2_3_2 isa Float64
    @test isapprox(Assignment02.ce_2_3_2, (24.95 * 0.6) * 60 + 3 + 59 * 0.75, atol = 1e-2)
end

@testset "Question 6" begin
    @test isapprox(bookprice(24.95, 0.4, 60), Assignment02.ce_2_3_2, atol=1e-2)
    @test isapprox(bookprice(24.95, 0.4, 1), 17.97)
    @test isapprox(bookprice(24.95, 0.4, 2), 33.69)
    @test isapprox(bookprice(1, 0, 1), 4.0)
end

end # "Assignment02"()
