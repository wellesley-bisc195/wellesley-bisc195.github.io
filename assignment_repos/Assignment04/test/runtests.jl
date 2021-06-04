using Assignment04
using Test

@testset "Assignment04" begin

seq = rand(['A','T','G','C'], 20) |> join

@testset "Question 1" begin
    @test normalizeDNA("aatg") == "AATG"
    @test_throws ErrorException normalizeDNA("ZCA")
    @test_throws ErrorException normalizeDNA(42)
    c = normalizeDNA('C') 
    @test c == "C"
    @test typeof(c) == String
end

@testset "Question 2" begin
    bc = basecomposition(seq)
    @test bc isa Tuple{Int,Int,Int,Int}
    a,c,g,t = bc

    @test a == count(x-> x == 'A', seq)
    @test c == count(x-> x == 'C', seq)
    @test g == count(x-> x == 'G', seq)
    @test t == count(x-> x == 'T', seq)

    a,c,g,t = basecomposition(lowercase(seq))

    @test a == count(x-> x == 'A', seq)
    @test c == count(x-> x == 'C', seq)
    @test g == count(x-> x == 'G', seq)
    @test t == count(x-> x == 'T', seq)

    @test_throws ErrorException basecomposition(a)
end

@testset "Question 3" begin
    @test gc_content("AATG") == 0.25
    @test gc_content("cccggg") * 100 == 100.0
    @test gc_content("ATta") == 0.0
    @test_throws ErrorException gc_content("ATty")
end

@testset "Question 4" begin
    @test_throws ErrorException kmercount("A", 2)
    
    a,c,g,t = basecomposition(seq)
    @test kmercount(seq,1) == Dict("A"=>a, "C"=>c, "G"=>g, "T"=>t)
    for k in 3:5
        @test sum(values(kmercount(seq, k))) == 20 - k + 1
    end

    @test kmercount("GCGCGCGCG", 5) == Dict("CGCGC" => 2, "GCGCG" => 3)
end

end # Assignment04
