using Assignment06
using Test
using Statistics

@testset "Assignment06" begin

testpath = normpath(joinpath(@__DIR__, "..", "data"))
genomes = joinpath(testpath, "cov2_genomes.fasta")
ex1_path = joinpath(testpath, "ex1.fasta")
ex2_path = joinpath(testpath, "ex2.fasta")

@testset "Question 1" begin
    @test count_records(genomes) == 8
    @test count_records(ex1_path) == 2
    @test count_records(ex2_path) == 4
end

@testset "Question 2" begin
    @test fasta_header(">M0002 |China|Homo sapiens") == ("M0002", "China", "Homo sapiens")
    @test_throws ErrorException fasta_header("AAATTC")
    @test fasta_header(">Another sequence") == ("Another sequence",)
    @test fasta_header(">headers| can | have| any number | of | info blocks") == ("headers", "can", "have", "any number", "of", "info blocks")
    for line in eachline(ex1_path)
        startswith(line, ">") && @test length(fasta_header(line)) == 2
    end        
end

@testset "Question 3" begin
    ex1 = parse_fasta(ex1_path)
    @test ex1 isa Tuple
    @test all(x-> x isa Tuple, ex1[1])
    @test all(x-> x isa String, ex1[2])

    @test ex1[1] == [("ex1.1", "easy"), ("ex1.2", "multiline")]
    @test ex1[2] == ["AATTATAGC", "CGCCCCCCAGTCGGATT"]

    ex2 = parse_fasta(ex2_path)
    @test ex2 isa Tuple
    @test all(x-> x isa Tuple, ex2[1])
    @test all(x-> x isa String, ex2[2])
    @test ex2[1] == [("ex2.1", "oneper"), ("ex2.2", "wrong"), ("ex2.3", "wronger"), ("ex2.4", "wrongest")]
    @test ex2[2] == ["ATCCGT", "ATCGTGGaact", "ATCGTGGaact", "this isn't a dna string,but parse it anyway"]
end

@testset "Question 4" begin
    seqs = String[]
    curseq = String[]
    for line in eachline(genomes)
        if startswith(line, ">")
            length(curseq) > 0 && push!(seqs, join(curseq))
            curseq = []
        else
            push!(curseq, line)
        end
    end
    push!(seqs, join(curseq))

    l = map(length, seqs)
    nonl = map(s-> length(filter(!=('N'), uppercase(s))), seqs)
    gc = map(x-> count(base-> occursin(uppercase(base), "CG"), x), seqs)

    @test Assignment06.mean_cov2_length == mean(l)
    @test Assignment06.std_cov2_length == std(l)
    @test Assignment06.mean_cov2_gc == mean(gc ./ l) || Assignment06.mean_cov2_gc == mean(gc ./ nonl)
    @test Assignment06.std_cov2_gc == std(gc ./ l) || Assignment06.std_cov2_gc == std(gc ./ nonl)

end


end # Assignment06
