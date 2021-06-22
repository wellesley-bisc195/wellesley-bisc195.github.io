# This file was generated, do not modify it. # hide
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