# This file was generated, do not modify it.

# To view additional instructions for this assignment,
# see https://wellesley-bisc195.github.io/assignments/Assignment05/

# To view a rendered version of this document,
# see https://wellesley-bisc195.github.io/assignments/Assignment05/#assignment05_code

function isreverse(word1, word2)
    if length(word1) != length(word2)
        return false
    end
    i = firstindex(word1)
    j = lastindex(word2)
    while j >= 0
        j = prevind(word2, j)
        if word1[i] != word2[j]
            return false
        end
        i = nextind(word1, i)
    end
    true
end

"""
    complement(base)

Get the DNA complement of the provided base:

    A <-> T
    G <-> C

Accepts uppercase or lowercase `String` or `Char`,
but always returns an uppercase `Char`.
If a valid base is not provided, the function throws an error.
"""
function complement(base)
    complements = Dict("A" => 'T',
                       "T" => 'A',
                       "G" => 'C',
                       "C" => 'G')

    base = uppercase(string(base))

    !(base in keys(complements)) && error("Invalid base $base")
    return complements[base]
end

"""
    isreversecomplement(seq1, seq2)

Boolean function that checks whether two DNA seqences
are the reverse complement of one another, irrespective of capitalization.
Returns true if yes, false otherwise.

If any invalid bases are encountered,
or if sequences are different length, throws an error.

Examples
≡≡≡≡≡≡≡≡≡≡

    julia> isreversecomplement("aaatttcg", "cgaaattt")
    true

    julia> if isreversecomplement("C", "A")
               println("Yes!")
           else
               println("No!")
           end
    No!

    julia> isreversecomplement("TX", "AG")
    Error: Invalid base X

    julia> isreversecomplement("G", "CC")
    Error: Cannot compare sequuences of different length
"""
function isreversecomplement(seq1, seq2)
    # your code here
end

"""
    reverse_complement(sequence)

Takes a DNA sequence and returns the reverse complement
of that sequence.

Takes lowercase or uppercase sequences,
but always returns uppercase.

Examples
≡≡≡≡≡≡≡≡≡≡
    julia> reverse_complement("AAATTT")
    "AAATTT"

    julia> reverse_complement("GCAT")
    "ATGC"

    julia> rc = reverse_complement("TTGGG");

    julia> println(rc)
    CCCAA
"""
function reverse_complement(sequence)
    # your code here
end

first15 = "#= put shell command here =#"

last15 = "#= put shell command here =#"

"""
    find_dna(file)

In a file with one word per line,
returns an array with all words that are valid DNA sequences
(that is, they contain only a, t, g, or c).

Words may be upper- or lowercase,
but returned array will contain only uppercase letters.

Example
≡≡≡≡≡≡≡≡≡
    julia> find_dna("data/words.txt") # assumes you're in Assignment05 directory
    13-element Array{Any,1}:
      "AA"
      "ACT"
      "ACTA"
      "AGA"
      "AT"
      "CAT"
      "GAG"
      "GAGA"
      "GAT"
      "TA"
      "TACT"
      "TAG"
      "TAT"
"""
function find_dna(file)
    # 1. You probably want to make an empty array

    for line in eachline(file)
        # if the line is valid dna, put it in the array
    end
end

