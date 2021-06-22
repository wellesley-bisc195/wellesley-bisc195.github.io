# This file was generated, do not modify it. # hide
"""
    complement(base)

Get the DNA complement of the provided base:

    A <-> T
    G <-> C

Accepts `String` or `Char`, but always returns `Char`.
If a valid base is not provided, the function throws an error.

Examples
≡≡≡≡≡≡≡≡≡≡

    julia> complement('A')
    'T'

    julia> complement("G")
    'C'

    julia> complement("T")
    'A'

    julia> complement('C')
    'G'
"""
function complement(base)
    # See Lesson 4 for more info
end