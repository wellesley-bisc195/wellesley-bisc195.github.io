# This file was generated, do not modify it. # hide
"""
    question3(sequence)

Calculates the GC ratio of a DNA sequence.
The GC ratio is the total number of G and C bases divided by the total length of the sequence.
For more info about GC content, see here: https://en.wikipedia.org/wiki/GC-content

Example
≡≡≡≡≡≡≡≡≡≡

    julia> question3("AATG")
    0.25

    julia> question3("CCCGG")
    1.0

    julia> question3("ATTA")
    0.0
"""
function question3(sequence)
    # throw an error if the string contains anything other than ACGT
    if any(c-> !in(c, ['A','C','G','T']), sequence)
        throw(ArgumentError("Sequence must only contain ACGT"))
    end

    # change line to assign `seqlength` to the length of `sequence` instead of `1`
    # If you're stuck, search for "length of string julia"
    seqlength = 1

    # count the number of G's
    gs = count(==('G'), sequence)
    # count the number of C's
    cs = count(==('C'), sequence)

    return gs + cs / seqlength # something is wrong with this line...
end