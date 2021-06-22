# This file was generated, do not modify it. # hide
"""
   kmercount(sequence, k)

Finds all kmers in a sequence,
returning a dictionary of those kmers
and the number of times they appear in the sequence.

Examples
≡≡≡≡≡≡≡≡≡≡

    julia> kmercount("ggg", 3)
    Dict{Any,Any} with 1 entry:
    "GGG" => 1

    julia> kmercount("ATATATATA", 4)
    Dict{Any,Any} with 2 entries:
    "TATA" => 3
    "ATAT" => 3

    julia> kmercount("ATATATATAx", 4)
    ERROR: Invalid base X encountered

    julia> kmercount("A", 2)
    ERROR: k must be a positive integer less than the length of the sequence
"""
function  kmercount(sequence, k)
    1 <= k <= length(sequence) || error("k must be a positive integer less than the length of the sequence")
    kmers = Dict() # initialize dictionary

    # We're going to loop through the string with numerical index,
    # each time grabbing the bases at position i through i+k-1.
    # What is the last index that we should search?
    stopindex = 0

    for i in 1:stopindex
        kmer = "" # Change to index the sequence from i to i+k-1
        kmer = normalizeDNA(kmer)
        #   if this kmer is a key the dictionary
        #       add 1 to the value referenced by that kmer
        #   otherwise
        #       make a new entry in the dictionary with a value of 1

    end
    return kmers
end