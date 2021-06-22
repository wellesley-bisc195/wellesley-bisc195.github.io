# This file was generated, do not modify it. # hide
"""
    function parse_fasta(path)

Reads a fasta-formated file and returns 2 vectors,
one containing parsed headers,
the other containing the entire sequence as a `String`.

Note: function does not validate DNA sequences for correctness.

Example
≡≡≡≡≡≡≡≡≡
    julia> ex1 = parse_fasta("data/ex1.fasta");

    julia> ex1 isa Tuple
    true

    julia> ex1[1]
    2-element Array{Tuple{String,String},1}:
      ("ex1.1", "easy")
      ("ex1.2", "multiline")

    julia> ex1[2]
    2-element Array{String,1}:
    "AATTATAGC"
    "CGCCCCCCAGTCGGATT"

    julia> ex2 = parse_fasta("data/ex2.fasta");

    julia> ex2[1]
    4-element Array{Tuple{String,String},1}:
      ("ex2.1", "oneper")
      ("ex2.2", "wrong")
      ("ex2.3", "wronger")
      ("ex2.4", "wrongest")

    julia> ex2[2]
    4-element Array{String,1}:
      "ATCCGT"
      "ATCGTGGaact"
      "ATCGTGGaact"
      "this isn't a dna string,but parse it anyway"
"""
function parse_fasta(path)
    # Think through the components you need
    # Does it make sense to define any containers at the beginning?
    # How will you loop through the file?
    # What do you need to get from each line?
end