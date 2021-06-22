# This file was generated, do not modify it. # hide
"""
    normalizeDNA(sequence)

Normalizes DNA sequences or bases to uppercase `String`s.
Throws an error if invalid bases are encountered.

Examples
≡≡≡≡≡≡≡≡≡≡

    julia> normalizeDNA("aaatg")
    "AAATG"

    julia> normalizeDNA("XTG")
    ERROR: Invalid base X encountered

    julia> normalizeDNA(5)
    ERROR: Invalid base 5 encountered

    julia> normalizeDNA('G')
    "G"

    julia> b = normalizeDNA('G');

    julia> typeof(b)
    String
"""
function normalizeDNA(sequence)
    # 1. make sequence into a String
    # 2. make sequence uppercase

    for base in sequence
        if !occursin(base, "ACGT")
            error("Invalid base $base encountered")
        end
    end

    # return the normalized sequence
end