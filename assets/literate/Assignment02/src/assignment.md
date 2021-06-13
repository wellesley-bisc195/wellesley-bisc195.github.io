<!--This file was generated, do not modify it.-->
# Instructions for Assignment02

## Introduction

In this assignment,
you will start to put the pieces together.
Note: this file is runnable in its current state,
but is incomplete.
You can run the file from the command line in script mode,
copy code into the REPL in interactive mode,
or use the VS Code julia extension to run individual lines.

The following code is used for set up;
there is no need to change it.
If you _do_ change it to figure out what it's doing,
make sure you change it back or your assignment may not work correctly

```julia:ex1
using Random
Random.seed!(42)

function generate_sequence(len)
    seq = join(rand(['A','C','G','T'], len))
    println("Your sequence is: ", seq)
    return seq
end

my_seq = generate_sequence(20)
```

## Question 1

The code above generates a random 20nt DNA sequence,
and assigns it to the variable `my_seq`.
What kind of data type is `my_seq` (eg `Float64`, `Int64`, `String`, or something else)?
Assign the variable `question1` to the correct type.

Hint1: rather than guess, you can just use the `typeof()` function.

```julia:ex2
question1 = ""
```

Hint2: If you're having trouble,
note that your answer should not contain quotes.
Eg. if you think that `seq` has the type `MyType`,
your code should read `question1 = MyType` and not `question1 = "MyType"`

## Question 2

The function bellow has a documentation string or "doc string",
which explains what the function should do.
Many julia functions have doc strings,
which makes it easy to get help right from the REPL

Open a julia REPL and type `?`.
You will see the `julia>` prompt change to `help?>`.
Now type `println` and hit enter.
The docstring of `println` is printed
and you're returned to a julia prompt

Evaluate the following function, including the docstring, in the REPL
(that is, copy from the triple quotes down to the "end"
and paste it into the REPL, then hit enter)

```julia:ex3
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
```

At the moment, this function doesn't do what it says it should.
Actually, it doesn't do anything.
Fix the function so that it takes one argument
and returns `true` if the argument is a String,
and returns `false` otherwise.
You should be able to run the examples in the docstring
and get the correct answer,
and to run this function using `my_seq` as the argument
(it should return `true`).

Hint: You haven't explicitly encountered a way to check if a type is another type.
Learning to search for answers is a key programming skill!
Try searching "check if type is string julia".
Typically, when I see search results, I prioritize in this order:
1. stackoverflow.com
2. docs.julialang.org
3. discourse.julialang.org
4. github.com

## Question 3

Let's try something a bit more complicated.
The `question3()` function has a doc string,
but is also incomplete.
I've writtten some code to get you started,
complete it so that the examples work as expected in the docstring.

```julia:ex4
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
```

## Question 4

This process should be familiar by now.

Hint: you do not need to re-write code if you already have it.
That is, don't copy any code from `question3`,
just call it!

```julia:ex5
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
```

The following are related to questions in the exercises
from chapter 2 of _Think Julia_.
The format of the varables below refer to specific exercise questions.
For example, `ce_2_1_1` would refer to chapter excercise 2-2, question 1.

> We’ve seen that `n = 42` is legal. What about `42 = n`?

Assign the variable to `true` if legal, `false` if illegal

```julia:ex6
ce_2_2_1 = Bool
```

> How about `x = y = 1`?

Assign the variable to `true` if legal, `false` if illegal

```julia:ex7
ce_2_2_2 = Bool
```

> The volume of a sphere with radius `r` is `4/3πr^3`.
What is the volume of a sphere with radius `5`?

Assign the variable to the correct answer

```julia:ex8
ce_2_3_1 = Float64
```

> Suppose the cover price of a book is \$24.95,
but bookstores get a 40 % discount.
Shipping costs \$3 for the first copy and 75 cents for each additional copy.
What is the total wholesale cost for 60 copies?

Assign the variable to the correct answer.

```julia:ex9
ce_2_3_2 = Float64

# Question 6
```

Write a function that calculates the cost of books,
given some list price, discount rate, and number.

```julia:ex10
"""
    bookprice(list, discount, count)

Calculates the price of books, given some list price, discount rate,
and number of books ordered.

Example
≡≡≡≡≡≡≡≡≡≡

    julia> bookprice(24.95, 0.4, 60)
```

this should be the same answer you got for `c_2_3_2`

```julia:ex11
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
```

