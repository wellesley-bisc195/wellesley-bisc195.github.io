# This file was generated, do not modify it. # hide
"""
    basecomposition(sequence)

Counts the number of each type of base
in a DNA sequence and returns a tuple those counts
in the order A, C, G, T

Examples
≡≡≡≡≡≡≡≡≡≡

    julia> basecomposition("AATCGGG")
    (2, 1, 3, 1)

    julia> basecomposition('C')
    (0, 1, 0, 0)

    julia> A,C,G,T = basecomposition("accgggtttt")
    (1, 2, 3, 4)

    julia> A
    1

    julia> T
    4

    julia> basecomposition("BACCGGGTTTT")
    ERROR: Invalid base B encountered
"""
function basecomposition(sequence)
    sequence = normalizeDNA(sequence) # make uppercase string, check invalid bases
    a = c = g = t = 0 # sets all 4 variables to `0`

    for base in sequence
        # add 1 to each base as it occurs
    end

    return a,c,g,t
end