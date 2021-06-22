# This file was generated, do not modify it. # hide
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