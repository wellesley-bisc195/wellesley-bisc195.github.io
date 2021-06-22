# This file was generated, do not modify it. # hide
"""
    gc_content(sequence)

Calculates the GC ratio of a DNA sequence.
The GC ratio is the total number of G and C bases divided by the total length of the sequence.
For more info about GC content, see here:

Examples
≡≡≡≡≡≡≡≡≡≡

    julia> gc_content("AATG")
    0.25

    julia> gc_content("cccggg") * 100
    100.0

    julia> gc_content("ATta")
    0.0

    julia> gc_content("ATty")
    Error: Invalid base Y encountered
"""
function gc_content(sequence)
    # Be sure to use `basecomposition()` in your answer.
    # Note: Since `basecomposition()` already calls `normalizeDNA`,
    # there's no need to call it here.
end