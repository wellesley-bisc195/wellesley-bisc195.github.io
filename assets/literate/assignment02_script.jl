# This file was generated, do not modify it.

# To view additional instructions for this assignment,
# see https://wellesley-bisc195.github.io/assignments/Assignment02

# To view a rendered version of this document,
# see https://wellesley-bisc195.github.io/assignments/Assignment02/#assignment02_code

using Random
Random.seed!(42)

function generate_sequence(len)
    seq = join(rand(['A','C','G','T'], len))
    println("Your sequence is: ", seq)
    return seq
end

my_seq = generate_sequence(20)

question1 = ""

"""
    question2(sequence)

Checks if `sequence` is a String.

Example
≡≡≡≡≡≡≡≡≡

    julia> question2("hello")
    true

    julia> question2(1001)
    false

    julia> if question2("I'm a string!")
               println("yeah, that was a string")
           end
    yeah, that was a string
"""
function question2()
    # put your code here
end

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

"""
    question4(sequence)

Calculates the GC content of a DNA sequence
and prints it to the screen.

Example
≡≡≡≡≡≡≡≡≡≡

    julia> question4("AATC")
    Sequence:
    AATC
    GC Content:
    0.25

    julia> question4("CCCGG")
    Sequence:
    CCCGG
    GC Content:
    1.0
"""
function question4(sequence)
    # Your code here
end

# Question 5

ce_2_2_1 = Bool

ce_2_2_2 = Bool

ce_2_3_1 = Float64

ce_2_3_2 = Float64

# Question 6

"""
    bookprice(list, discount, count)

Calculates the price of books, given some list price, discount rate,
and number of books ordered.

Example
≡≡≡≡≡≡≡≡≡≡

    julia> bookprice(24.95, 0.4, 60)

    julia> bookprice(24.95, 0.4, 1)
    17.97

    julia> bookprice(24.95, 0.4, 2)
    33.69

    julia> bookprice(1, 0, 1)
    4.0
"""
function bookprice(list, discount, count)
    # your code here
end

