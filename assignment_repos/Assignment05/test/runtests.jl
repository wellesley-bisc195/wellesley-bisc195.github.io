using Assignment05
using Test



@testset "Assignment05" begin

testpath = normpath(joinpath(@__DIR__, "..", "data", "test.txt"))
wordspath = normpath(joinpath(@__DIR__, "..", "data", "words.txt"))

@testset "Question 1" begin
    @test isreverse("racecar", "racecar")
    @test isreverse("GATA", "ATAG")
    @test !isreverse("GATA", "GTAG")
    @test !isreverse("1234", "1234")
end

@testset "Question 2" begin
    @test isreversecomplement("aaatttcg", "cgaaattt")
    @test !isreversecomplement("C", "A")
    @test_throws ErrorException isreversecomplement("TX", "AG")
    @test_throws ErrorException isreversecomplement("G", "CC")
end

@testset "Question 3" begin
    @test reverse_complement("AAATTT") ==  "AAATTT"
    @test reverse_complement("GCAT") == "ATGC"
    @test reverse_complement("TTGGG") == "CCCAA"
    
end

@testset "Question 4" begin
    q4a = string.(split(Assignment05.first15))[1:end-1]
    push!(q4a, wordspath)
    f15 = split(read(Cmd(q4a), String), '\n', keepempty=false)
    alllines = readlines(wordspath)
    @test f15 == alllines[1:15]
    q4b = string.(split(Assignment05.last15))[1:end-1]
    push!(q4b, wordspath)
    l15 = split(read(Cmd(q4b), String), '\n', keepempty=false)
    @test l15 == alllines[end-14:end]
end

@testset "Question 5" begin
    alllines = uppercase.(readlines(testpath))
    filter!(l-> all(c-> in(c, "ATGC"), l), alllines)
    @test length(alllines) == 3
    @test alllines == find_dna(testpath)
end

end # Assignment05
