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
you still have some work to do

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
 "Checking Question"
@@

Which test failed, and which test was an error?

Run the example in the REPL;
can you find any relevant information in the stacktrace?
@@

If you'd like to examine the tests for this assignment,
take a look inside `test/runtests.jl` in your assignment repository.
A lot of things will likely be unfamiliar,
but you might find some hints for how to finish the assignment...

{{literate_assignment 2}}