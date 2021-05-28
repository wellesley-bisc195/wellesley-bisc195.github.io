# This file was generated, do not modify it.

# To view additional instructions for this assignment,
# see https://wellesley-bisc195.github.io/assignments/Assignment03/

# To view a rendered version of this document,
# see https://wellesley-bisc195.github.io/assignments/Assignment03/#assignment03_code

"""
    compliment(base)

Get the DNA compliment of the provided base:

    A <-> T
    G <-> C

Accepts `String` or `Char`, but always returns `Char`.
If a valid base is not provided, the function throws an error.

Examples
≡≡≡≡≡≡≡≡≡≡

    julia> compliment('A')
    'T'

    julia> compliment("G")
    'C'

    julia> compliment("T")
    'A'

    julia> compliment('C')
    'G'
"""
function compliment(base)
    # See Lesson 3 for more info
end

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

"""
    base_type(base)

Determines whether a base is a purine (A or G) or pyrimidine (T or C),
and returns a `String`.

Examples
≡≡≡≡≡≡≡≡≡≡

    julia> base_type("G")
    "purine"

    julia> base_type('C')
    "pyrimidine"

    julia> base_type('Z')
    Error: "Base Z not supported"

    julia> x = base_type('A'); println(x)
    purine
"""
function base_type(base)
    # Note: this is different than the `base_type()` we defined in the lesson.
    # Here, we want a fruitful function that returns the value rather than `print`ing it.
    # Also, there's no need to re-write the logic. If your `ispurine` / `ispyrimidine` functions work,
    # you can use them here.
end

"""
    gc_content(sequence)

Calculates the GC ratio of a DNA sequence.
The GC ratio is the total number of G and C bases divided by the total length of the sequence.
For more info about GC content, see here:

Example
≡≡≡≡≡≡≡≡≡≡

    julia> gc_content("AATG")
    0.25

    julia> gc_content("cccggg") * 100
    100.0

    julia> gc_content("ATta")
    0.0
"""
function gc_content(sequence)
    # Start with the same code as `question3()` from assignment 2.
    # only a small modification is necessary to make this work.
end

