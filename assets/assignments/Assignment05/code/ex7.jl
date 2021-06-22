# This file was generated, do not modify it. # hide
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