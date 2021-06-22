using Assignment03
using Test

bases = ["ATGC"...; string.(["ATGC"...])]
cbases = ["TACG"...]
notbases = ["BDXZ"...; string.(["BDXZ"...])]
pur = ('A','G')
pyr = ('T','C')

@testset "Assignment03" begin

@testset "Question 1" begin
    @test all(x-> complement(x) isa Char, bases)
    
    for i in 1:4
        @test complement(bases[i]) == cbases[i]
        @test complement(bases[i+4]) == cbases[i]
    end
    for b in notbases
        @test_throws ErrorException complement(b)
    end
end

@testset "Question 2" begin
    @test all(ispurine, pur)
    @test all(ispyrimidine, pyr)
    @test all(p-> ispurine(p) == !ispyrimidine(p), bases)

    for b in notbases
        @test_throws ErrorException ispurine(b)
        @test_throws ErrorException ispyrimidine(b)
    end
end

@testset "Question 3" begin
    @test all(p-> base_type(p) == "purine", pur)
    @test all(p-> base_type(p) == "pyrimidine", pyr)
    for i in 1:4
        @test base_type(bases[i]) == base_type(bases[i+4])
        @test base_type(bases[i]) != base_type(cbases[i])
    end
    for b in notbases
        @test_throws ErrorException base_type(b)
    end
end

@testset "Question 4" begin
    @test gc_content(join(bases)) == 0.5
    @test gc_content(join(bases[1:5])) == 0.4
    @test gc_content(lowercase(join(bases))) == 0.5
    @test gc_content(lowercase(join(bases[1:5]))) == 0.4
end

@testset "Question 5" begin
    for b in bases, f in [complement, ispurine, ispyrimidine, base_type]
        @test f(b) == f(lowercase(b))
    end
end

end # Assignment03