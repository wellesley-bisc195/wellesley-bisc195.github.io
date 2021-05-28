# This file was generated, do not modify it. # hide
using Random
Random.seed!(42)

function generate_sequence(len)
    seq = join(rand(['A','C','G','T'], len))
    println("Your sequence is: ", seq)
    return seq
end

my_seq = generate_sequence(20)