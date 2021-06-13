+++
number = 2
title = "Data types and Functions"
due_date = Date(2021,06,14)
classroom = "4FgCLmLn"
+++

{{assignment_preamble}}

## Instructions

As you did with [Assignment01](/assignments/Assignment01),
click the [invite link](https://classroom.github.com/a/4FgCLmLn)
to make a new copy of the assignment repository.

Then, clone the repository, and look at the `src/assignment.jl` file,
which contains information for what needs to be done.

## Unit Tests

You may or may not have noticed that each of your assignments
has automated "unit testing" set up to check that your code works as expected.

Once you've completed the assignment,
you will see a green checkmark next to the commit in github

![Github CI passing](https://imgur.com/kb5YuDL.png)

You can also check this on your own computer -
with your assignment repository as the working directory, run:

```sh
$ julia --project -e 'using Pkg; Pkg.test()'
```

If you do this before you've completed the assignment,
you'll probably see a bunch of error messages,
along with the test results:

```
Test Summary: | Pass  Fail  Error  Total
Assignment02  |    6     3      5     14
  Setup       |    3                   3
  Question 1  |          2             2
  Question 2  |    1            4      5
  Question 3  |    1     1             2
  Question 4  |    1            1      2
ERROR: LoadError: Some tests did not pass: 6 passed, 3 failed, 5 errored, 0 broken.
```

Unit tests are widely used in computer programing
so that developers can be certain that their code is working the way they intend.
I'm using them here so you can tell how close you are to completing your assignment.

In later assignments, and in your final project,
you will write your own unit tests for the code that you write.
For now, you can just be assured that if all tests pass,
you're done, and if they don't,
you still have some work to do.

### How tests work

Tests take the form of "Boolean" expressions -
that is, things that return `true` or `false`.
Boolean expressions are also also used in conditional execution,
which you'll learn about in [Lesson 4](/lessons/Lesson04).

```julia
julia> using Test

julia> @test true
Test Passed

julia> @test false
Test Failed at REPL[3]:1
  Expression: false
ERROR: There was an error during testing
```

"Passing" tests are those that evaluate `true`.
"Failing" tests are those that evaluate `false`.
Errors are reported when the expression throws an error
before returning a value,
or when the expression doesn't return either `true` or `false`  .

There are lots of different types of boolean expressions.
For example, `==` is used to ask if two values are equal.

```julia
julia> 1 + 1 == 2
true

julia> x = 3; # remember, one `=` is for assigning variables

julia> x == 6 / 2
true

julia> "3" == x
false
```

There are also many built-in functions whose role is to check something,
returning a boolean value.

```julia
julia> isodd(42)
false

julia> iseven(12)
true
```

We can define "testsets" that check a bunch of expressions
and report the information

```julia
julia> using Test

julia> @testset "Example tests" begin
           lifeuniverseeverything = 42
           age = 35
           pi = 3.14

           @test iseven(lifeuniverseeverything)
           @test iseven(age)
           @test iseven(pi)
       end
```
```
Test Summary: | Pass  Fail  Error  Total
Example tests |    1     1      1      3
```

@@colbox-orange
@@title
Checking Question
@@

Which test failed, and which test was an error?

Run the example in the REPL;
can you find any relevant information in the stacktrace?
@@

If you'd like to examine the tests for this assignment,
take a look inside `test/runtests.jl` in your assignment repository.
A lot of things will likely be unfamiliar,
but you might find some hints for how to finish the assignment...

## Running your code during development

In this assignment, you will start to write functions
that accomplish some task.
Almost inevitably, you will need to try many different things
before your function(s) do what you want them to.
How can you build your code incrementally, while testing what it does?

You'll learn several different ways to do this in this course -
no one way is obviously better than another,
each has advanatages and disadvantages.

### REPL-based development

The most straightforward development strategy is to use the REPL
as your primary playground.
You can try different function definitions
with different inputs, and then once you get something that works,
copy the code from the REPL into your code files.

For example, let's say you're trying to solve [question 3](#question_3)
of this assignment.
You're given some starter code,
and a description of what you're trying to do:

```
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

The first thing to do is copy the code into the REPL and execute it.

```julia-repl
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.6.0 (2021-03-24)
 _/ |\__'_|_|_|\__'_|  |
|__/                   |

julia> function question3(sequence)
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
question3 (generic function with 1 method)

julia>
```

Now let's try the examples and see what happens:

```julia-repl
julia> question3("AATG")
1.0

julia> question3("CCCGG")
5.0

julia> question3("ATTA")
0.0
```

Hmm - instead of giving me the *ratio* of GCs,
it seems to be giving me a *count* of GCs.
The first hint tells me I need to replace `seqlength = 1`
to assign the length of the sequence instead of `1`.
I'm not sure how to do that, let's see what happens
if I enter the length by hand.

First, I'll change the code in the assignment file to set `seqlength = 4`,
then copy and paste the whole block into the REPL,
then run the first example again.

```julia-repl
julia> function question3(sequence)
           # throw an error if the string contains anything other than ACGT
           if any(c-> !in(c, ['A','C','G','T']), sequence)
               throw(ArgumentError("Sequence must only contain ACGT"))
           end

           # change line to assign `seqlength` to the length of `sequence` instead of `1`
           # If you're stuck, search for "length of string julia"
           seqlength = 4

           # count the number of G's
           gs = count(==('G'), sequence)
           # count the number of C's
           cs = count(==('C'), sequence)

           return gs + cs / seqlength # something is wrong with this line...
       end
question3 (generic function with 1 method)

julia> question3("AATG")
1.0
```

Rats! That didn't seem to change anything.
What about if I change it to 5, and do the second example?

```julia-repl
julia> function question3(sequence)
           # throw an error if the string contains anything other than ACGT
           if any(c-> !in(c, ['A','C','G','T']), sequence)
               throw(ArgumentError("Sequence must only contain ACGT"))
           end

           # change line to assign `seqlength` to the length of `sequence` instead of `1`
           # If you're stuck, search for "length of string julia"
           seqlength = 5

           # count the number of G's
           gs = count(==('G'), sequence)
           # count the number of C's
           cs = count(==('C'), sequyouence)

           return gs + cs / seqlength # something is wrong with this line...
       end
question3 (generic function with 1 method)

julia> question3("CCCGG")
2.6
```

Well, it's not right, but at least that changed the answer.
But I'm not sure where to go next.

Let's try the function line-by line, to see what's happening.
First, I'll assign `sequence = "AATG"`,
to mimic passing that as an argument to the function
(we'll learn more about functions and arguments in the next lesson).
Then, I'll copy and paste each line of the function into the REPL
to see if it's doing what I expect.

```julia-repl
julia> if any(c-> !in(c, ['A','C','G','T']), sequence)
          throw(ArgumentError("Sequence must only contain ACGT"))
       end

julia> seqlength = 4 # will figure this out later
4

julia> # count the number of G's
       gs = count(==('G'), sequence)
1

julia> # count the number of C's
       cs = count(==('C'), sequence)
0
```

So far so good - so it must be the last line)

```julia-repl
julia> gs + cs / seqlength
1.0
```

OK, so that's what we got the first time.
What we want is the sum of gs and cs, divided by the length.
So let's try each piece

```julia-repl
julia> cs + gs
1

julia> cs / seqlength
0.0
```

See the problem? If not, try the same thing, but set `sequence = "CCCGG"`
and `seqlength = 5`, then go through each line again.

@@colbox-green
@@title
Tip
@@
You can always make your changes directly in the REPL,
rather than copy-pasting them from your assignment file.
Just remember to update your assignment file once you get some working code.

If you press the up arrow, you can cycle through previous commands.
Just remember that you can't use your mouse to move the cursor.
@@
@@colbox-blue
@@title
Note
@@
Copying back and forth between the REPL and a file
may introduce some weird spacing.

Mostly, julia doesn't care about whitespace like spaces and newlines,
and in the REPL, it doesn't matter much.
But try to keep your assignment code nicely aligned,
with blocks indented, and `end` keywords aligned
with the statement that they terminate.

It makes it easier to read (for you _and_ for me)
and easier to spot problems.
@@

{{literate_assignment 2}}
