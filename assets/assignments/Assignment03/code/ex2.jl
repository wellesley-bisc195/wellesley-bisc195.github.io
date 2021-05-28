# This file was generated, do not modify it. # hide
"""
    ispurine(base)

A boolean function that returns `true` if the base is a purine (A or G)
and `false` if it is not.
The function only supports bases A, C, G, and T (throws an error for other values).
Accepts `String` or `Char`.

Examples
=========

    julia> ispurine('A')
    true

    julia> ispurine("C")
    false

    julia> if ispurine("G")
               println("It's a purine!")
           else
               println("It's a pyrimidine!")
           end
    It's a purine!

    julia> ispurine('B')
    Error: "Base B not supported")
"""
function ispurine(base)
    # We haven't made this before, but you should have all the pieces
end

"""
    ispyrimidine(base)

A boolean function that returns `true` if the base is a pyrimidine (C or T)
and `false` if it is not.
The function only supports bases A, C, G, and T (throws an error for other values).
Accepts `String` or `Char`.

Examples
=========

    julia> ispyrimidine('G')
    false

    julia> ispyrimidine("T")
    true

    julia> if ispyrimidine("G")
               println("It's a pyrimidine!")
           else
               println("It's a purine!")
           end
    It's a purine!

    julia> ispyrimidine('X')
    Error: "Base X not supported"
"""
function ispyrimidine(base)
    # This is the strict opposite of `ispurine`.
    # In principle, you can write this in one line - remember `!` means `NOT`.
    # Eg `isuppercase(x)` means the same thing as `!islowercase(x)`
end