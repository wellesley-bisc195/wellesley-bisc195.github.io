# This file was generated, do not modify it.

# To view additional instructions for this assignment,
# see https://wellesley-bisc195.github.io/BISC195.jl/stable/Assignments/assignment06

# To view a rendered version of this document,
# see https://wellesley-bisc195.github.io/BISC195.jl/stable/Assignments/assignment06_code

"""
    count_records(path)

Given a path to a `fasta` file,
counts and returns the number of records it contains.

Example
≡≡≡≡≡≡≡≡≡
    julia> count_records("data/cov2_genomes.fasta")
    10
"""
function count_records(path)
    # Your code here.
end

"""
    fasta_header(header)

Divides a fasta header into its component parts,
removing any leading or trailing spaces.

Example
≡≡≡≡≡≡≡≡≡
    julia> fasta_header(">M0002 |China|Homo sapiens")
    ("M0002", "China", "Homo sapiens")

    julia> fasta_header("AAATTC")
    Error: Invalid header (headers must start with '>')

    julia> fasta_header(">Another sequence")
    ("Another sequence",)

    julia> fasta_header(">headers| can | have| any number | of | info blocks")
    ("headers", "can", "have", "any number", "of", "info blocks")
"""
function fasta_header(header)
    startswith(header, '>') || error("Invalid header (headers must start with '>')")

    # Your code here
end

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

# helper code goes here

mean_cov2_length = 0.0
std_cov2_length = 0.0

# helper code goes here

mean_cov2_gc = 0.0
std_cov2_gc = 0.0

