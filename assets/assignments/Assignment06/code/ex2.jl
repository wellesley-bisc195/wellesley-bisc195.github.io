# This file was generated, do not modify it. # hide
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