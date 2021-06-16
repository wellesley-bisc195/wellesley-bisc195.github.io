+++
number = 3
title = "Functions, functions, and more functions!"
date = Date(2021, 06, 15)
+++

{{lecture_preamble}}

## Lab 3 - Needleman-Wunch Aligner, Part 1

In this lab, you will begin constructing a sequence aligner
based on the [Needleman-Wunch algorithm](https://en.wikipedia.org/wiki/Needleman%E2%80%93Wunsch_algorithm).
This is a classic bioinformatics method, and quite accessible.

### Fork and clone the lab repository

We'll be keeping track of all of your labs in a single git repository.
Follow the instructions laid out in the [Lab 2 bonus](/lectures-labs/Lecture02/#bonus_help_me_improve_the_scavenger_hunt),
for forking and making a pull request,
but use the [`BISC195Labs` repository](https://github.com/wellesley-bisc195/BISC195Labs).

Here's a summary - more details are available at the link above.

1. Fork the `BISC195Labs` repo
2. Clone the repo with `git clone <url>`
3. Make a new branch with `git branch <branchname>` (note: don't include the `<` or `>` in your branch's name)
4. Checkout the branch with `git checkout <branchname>`
   (note: you can combine steps 2 and 3 with `git checkout -b <branchname>`)
5. This is going to be a julia package, so add yourself as an author to the
   [`Project.toml`](https://github.com/wellesley-bisc195/BISC195Labs/blob/main/Project.toml#L3).
   This field is like a julia array, so it should take the form `["Kevin Bonham, PhD", "Your name"]`
6. Push the changes using `git push -u origin <branchname>`
7. Open a pull request to the main repo

Please include your name in the PR title.

### Step 1 - Take a look around

Like your assignments, this lab repo is structured like a julia package.
We'll talk more about the various compenents a lot more as the course progresses;
for now, notice that there are some code files found in the `src/` directory,
including the `BISC195Labs.jl` file, which defines the `BISC195Labs` module
(more on that later), and `include`s the file `needleman_wunch.jl`.

The `needleman_wunch.jl` file contains several methods
for a function called `nwscore()`.
The first method, which takes two `Char`s as arguments, is currently empty.
The other methods take a `Char` and a `Nothing` (what's going on with the 3rd method??),
or two `Nothing`s as arguments.
Can you infer what they're doing?

There's also a `test/` directory that includes a `runtests.jl` file,
which already contains some unit tests for the `nwscore()` function.
Based on the unit tests, can you get a sense of what the function is supposed to do?

What happens if you run the tests?
A reminder, you can run tests from the command line by doing

```sh
$ julia --project -e 'using Pkg; Pkg.test()'
```

or from the julia REPL by typing `]` to get the Pkg REPL,
then running `test`.

~~~
<script id="asciicast-xBnvAzIMLKp90LPFekzuPiet7" src="https://asciinema.org/a/xBnvAzIMLKp90LPFekzuPiet7.js" async></script>
~~~

Notice how many tests pass, how many fail, and how many error.

### Step 2 - Begin working on your function

The first thing to nail down in the NW algorithm is a function
that will score two bases, as either a match or a mismatch.
At first, just assume you're using the scoring from the original Needleman-Wunch
paper from 1970 - matches should score `+1` and mismatches should score `-1`.

Add code to the first method that will accept two bases (`Char`s)
and return the correct score.

Once this is accomplished, you should go from 8 passing tests to 18.
Nice!
There's still a ways to go though.

## Step 3 - adding keyword arguments (kwargs)

In julia, function arguments can be "positional"
(determined based on their order in the function call)
or "keyword" arguments (an identifier is used in the function call).

Keyword arguments (often called "kwargs")
are separated from positional arguments by a `;`.

For example:

```julia-repl
julia> function testing_args(pos1, pos2; kwarg1, kwarg2)
           @info "Pos 1 arg always comes first" pos1
           @info "Pos 2 arg always comes second" pos2
           @info "Kwargs can come in any order" kwarg1 kwarg2
       end
testing_args (generic function with 1 method)

julia> testing_args(1, 2; kwarg1 = 3, kwarg2 = 4)
┌ Info: Pos 1 arg always comes first
└   pos1 = 1
┌ Info: Pos 2 arg always comes second
└   pos2 = 2
┌ Info: Kwargs can come in any order
│   kwarg1 = 3
└   kwarg2 = 4

julia> testing_args(2, 1; kwarg2 = 4, kwarg1 = 3)
┌ Info: Pos 1 arg always comes first
└   pos1 = 2
┌ Info: Pos 2 arg always comes second
└   pos2 = 1
┌ Info: Kwargs can come in any order
│   kwarg1 = 3
└   kwarg2 = 4
```

Kwargs are often given default values so that a function will work without them,
but can be tuned according to the caller's needs.

We want our `nwscore()` function to be able to accept alternative scoring systems.
In principle, this could be done with positional arguments,
but that would require the user to remember the order that the scores are entered,
and potentially make it necessary to include extra arguments,
even if only changing one default.
Eg, if I wrote the function with positional arguments in the order
`match`, `mismatch`, `gap`,
then if I wanted to call this with a gap score of `-2`,
but defaults for match and mismatch,
I'd still have to call `nwscore(base1, base2, 1, -1, -2)`,
whereas with kwargs, I can call `nwscore(base1, base2; gap=-2)`.

Rewrite your first method to include keyword arguments
for setting the `match` and `mismatch` score.

@@colbox-blue
@@title
Tip
@@
Don't forget us actually _use_ those arguments in the body of your function.
@@

We're getting closer! Once this step is finished,
we should be up to 28 passing tests.

### Step 4 - Deal with different gap scores

Repeat the same procedure with the methods for gaps,
including a keyword argument for setting the gap score.
You'll need to modify both methods - how does the second gap method work?

Woo! The tests should now all pass!
But we're not done...

### Step 5 - kwarg compatibility

This is all well and good if someone knows ahead of time
whether they are scoring a match/mismatch or a gap,
but what happens if someone scores a gap, but includes different scores
for `match` or `mismatch` (or vise versa)?

```julia-repl
julia> nwscore('A', 'T')
-1

julia> nwscore('A', 'T'; mismatch=-2, match = 3)
-2

julia> nwscore('A', 'T'; mismatch=-2, match = 3, gap=-2)
ERROR: MethodError: no method matching nwscore(::Char, ::Char; mismatch=-2, match=3, gap=-2)
```

1. Add a few test cases that deal with different combinations of this situation.
   They should throw errors as your code currently stands.
2. Add a `gap` keyword argument to the `nwscore` method that takes 2 `Char`s
   and `match` and `mismatch` kwargs to the methods that take a `Char` and a `Nothing`.
   Do your tests pass now? If not, did you write the tests incorrectly, or the methods?

### Step 6 - Test double gap

The final method defined in the lab template is designed to throw an error
if it gets two `nothing` values.
How do we test that,
since `@test` only deals with `true` or `false` (boolean values)?

Julia's testing library has a special macro `@test_throws`,
to check if an expression throws an error.
It takes the form `@test_throws <error type> <expr>`,
where `<error type>` is something that's a subtype of `Exception`,
and `<expr>` is any julia expression.

For example:

```julia-repl
julia> using Test

julia> sqrt(-2)
ERROR: DomainError with -2.0:
sqrt will only return a complex result if called with a complex argument. Try sqrt(Complex(x)).
Stacktrace:
 [1] throw_complex_domainerror(f::Symbol, x::Float64)
   @ Base.Math ./math.jl:33
 [2] sqrt
   @ ./math.jl:582 [inlined]
 [3] sqrt(x::Int64)
   @ Base.Math ./math.jl:608
 [4] top-level scope
   @ REPL[8]:1

julia> @test_throws DomainError sqrt(-2)
Test Passed
      Thrown: DomainError

julia> @test_throws BoundsError sqrt(-2)
Test Failed at REPL[10]:1
  Expression: sqrt(-2)
    Expected: BoundsError
      Thrown: DomainError
ERROR: There was an error during testing
```

Write tests that check to make sure that `nwscore(nothing, nothing)`
throws the correct error.
Be sure to also test the function with different keyword arguments...

### Step 7 - Document your function

In the doc string for `nwscore`, write out the new signature,
and describe its functionality for someone that's never used it before.
You can use the docstrings in your assignments,
or the ones from your favorite julia functions as inspiration.

@@colbox-blue
@@title
Tip
@@
Remember that you can type `?` in the julia REPL to bring up the help REPL

```julia-repl
help?> isa
search: isa isascii isapprox isabspath isassigned isabstracttype disable_sigint isnan ispath isvalid ismarked istaskdone istaskfailed istaskstarted isreal

  isa(x, type) -> Bool


  Determine whether x is of the given type. Can also be used as an infix operator, e.g. x isa type.

  Examples
  ≡≡≡≡≡≡≡≡≡≡

  julia> isa(1, Int)
  true

  julia> isa(1, Matrix)
  false

  julia> isa(1, Char)
  false

  julia> isa(1, Number)
  true

  julia> 1 isa Number
  true
```
@@

You may spread your documentation out accross all of the methods,
or do a single docstring that contains information about all methods.

### Step 8 - Test-driven development

In preparation for completing the Needleman Wunch alignment,
you should start thinking about how it will actually work.
Assume that you want to write a function `nwalign()`
that takes 2 sequences and a scoring system,
and returns the best alignment.

Some things to consider:

1. What is the form of the returned value?
   Eg. is it a String, a Tuple?
   Do you return the score as well?
2. What happens when there's only 1 best alignment?
   What happens when there's more than 1?
3. What kinds of inputs are allowed?
   Are there multiple methods of your function?

There are many things to consider when developing functionality,
but thinking about inputs and outputs is generally a good way to start.

Create a new testset in `test/runtests.jl` that includes some tests
for how you think `nwalign()` should work.
Also create a skeleton function in `src/needleman_wunch.jl`, eg

```julia
function nwalign()
    # aligner
end
```

and add it to the exports in `src/BISC195Labs.jl`.
Take a look at your assignments if you're unsure how to make a new testset,
or how to do exports.

Once you've done this, you should see your new testset
with failing tests when you run them - if you get a `LoadError`
or something else that prevents your tests from running at all,
you've probably just got an issue with syntax.

### Step 9 - Push your code to github

If you set up your pull request correctly in Step 1,
you should just be able to `git push`,
and your pull request will update.

You don't need to wait until you've finished to push your code.
Push early and often, I say!