+++
number = 7
title = "Finishing alignments"
date = Date(2021, 06, 29)
+++

{{lecture_preamble}}

## Completing Needleman-Wunsch and Smith-Waterman aligners

We now need to add one more component to our scoring algorithm -
retracing the scoring steps to determine the alignment
or alignments[^multiple] that lead to the best possible score.

There are 2 ways to approach this:

1. Loop back through a completed scoring matrix like the one above,
   and figure out where the score came from.
2. Modify `nwscorematrix()` to keep track of whether a given score
   came from a gap direction and/or the diagonal,
   and then return that information.

There are merits and draw-backs to each approach.

In this lab, you will

1. Create a function that returns one best alignment from a NW alignment
2. Create a function that returns one best alignment from a SW alignment
3. Document your functions
4. Write unit tests for your functions

You will add your functions to the AlignmentAlgorithms package
that we've been creating in the previous labs.

[^multiple]: Note - many sequence pairs will have multiple "best" alignments. Initially, I was going to have you write functions that would return all of them, but after working for over an hour to do that myself, I decided that it was too much. If you'd like an additional challenge, you can try to do it too - there are some pointers written below - but you are only required to return **one** best alignment for this lab.

### Steps 1 & 2 - Alignments

As we've seen, we can generate a NW or SW scoring matrix
from any pair of sequences.
Now, your task is to return an alignment of those sequences.

For NW, the alignment should be a global alignment,
tracing the scoring matrix from the lower right,
and containing all bases from both sequences.

For SW, the alignment should be a local alignment,
tracing back from the highest score in the matrix
until the score reaches zero.

In both cases, you should return a `Tuple` of `String`s,
where the first item is the alignment of `seq1`,
and the second is the alignment of `seq2`.
You should represent gaps as a series of `-`.

### Step 3 - Documentation strings

Each of your functions should contain docstrings
that show the function signature,
explain what the function does,
and has some examples of use.
You may use your assignment repos as inspiration.

### Step 4 - Unit tests

Each of your functions should be tested on a variety of inputs,
including different scoring systems.
Test what happens when someone enters the wrong inputs
(eg a `Char`, empty strings, `Float64` as scores),
does it throw reasonable errors?

### Keeping track of a (potentially) ever-expanding group of alignments

@@colbox-orange
@@title
Bonus Challenge
@@
If you are interested in a little extra challenge,
you may try to modify your functions to return multiple best alignments.
You are **not** required to read beyond this point to complete this lab.
@@

Before you run a Needleman-Wunsch or Smith-Waterman alighnment,
there's no way to know how many different alignments will be maximim scorers.
For problems where you don't know the shape of the solution ahead of time,
using a mutable container, like an array or a dictionary
is probably the right choice.

In [Assignment05](/assignments/Assignment05),
you used a dictionary to keep track of the counts of kmers
as you encountered them.
In this case, your keys could be indices of the matrix,
and the values could be a vector of which indices they seed.

Alternatively, you could use an array or groups of arrays.
Did you know you can nest arrays inside arrays 😲?

Here's an example of how I could build the alignments above,
ignoring the details of scoring.

@@colbox-green
@@title
Tip
@@
You probably haven't seen the `vcat` function before,
or you may not remember how it works if you have seen it.
Use the help REPL to look at its docstring.
Try out a couple of examples,
and break down the following expressions in the REPL
to see how they work.
@@

@@colbox-orange
@@title
Warning
@@
The following code is overwhelming!
You've just been introduced to arrays,
and I'm doing a bunch of crazy stuff with them.

You are not expected to be able to read this and have it immediately make sense.
Pull the code apart, run pieces of it.
Try to modify it to do other things.
Look at docstrings.
@@

```julia-repl
julia> alignments = [
               ['A' 'A'], # this is a 1x2 array
               ['A' '-']  # col1 is sequence 1, col2 is sequence 2
                   ] # this is a vector or 2D arrays
2-element Vector{Matrix{Char}}:
 ['A' 'A']
 ['A' '-']

julia> push!(alignments, alignments[1]) # the alignment represented by index 1 branches, so I have one at index 3
3-element Vector{Matrix{Char}}:
 ['A' 'A']
 ['A' '-']
 ['A' 'A']

julia> alignments[1] = vcat(alignments[1], ['A' 'A']);

julia> alignments[2] = vcat(alignments[2], ['A' 'A']);

julia> alignments[3] = vcat(alignments[3], ['A' '-']);

julia> alignments
3-element Vector{Matrix{Char}}:
 ['A' 'A'; 'A' 'A']
 ['A' '-'; 'A' 'A']
 ['A' 'A'; 'A' '-']

julia> alignments[1] = vcat(alignments[1], ['A' '-']);

julia> alignments[2] = vcat(alignments[2], ['A' 'A']);

julia> alignments[3] = vcat(alignments[3], ['A' 'A']);

julia> alignments[1] = vcat(alignments[1], ['T' 'T']);

julia> alignments[2] = vcat(alignments[2], ['T' 'T']);

julia> alignments[3] = vcat(alignments[3], ['T' 'T']);

julia> alignments[1] = vcat(alignments[1], ['G' 'G']);

julia> alignments[2] = vcat(alignments[2], ['G' 'G']);

julia> alignments[3] = vcat(alignments[3], ['G' 'G']);

julia> alignments
3-element Vector{Matrix{Char}}:
 ['A' 'A'; 'A' 'A'; … ; 'T' 'T'; 'G' 'G']
 ['A' '-'; 'A' 'A'; … ; 'T' 'T'; 'G' 'G']
 ['A' 'A'; 'A' '-'; … ; 'T' 'T'; 'G' 'G']

julia> alignments[1]
5×2 Matrix{Char}:
 'A'  'A'
 'A'  'A'
 'A'  '-'
 'T'  'T'
 'G'  'G'

julia> alignments[2]
5×2 Matrix{Char}:
 'A'  '-'
 'A'  'A'
 'A'  'A'
 'T'  'T'
 'G'  'G'

julia> alignments[3]
5×2 Matrix{Char}:
 'A'  'A'
 'A'  '-'
 'A'  'A'
 'T'  'T'
 'G'  'G'
```

Of course, you won't be doing this by hand,
you'll need to think about how to do it in loops,
keeping track of which branch you're on,
in case you need to copy it to a new branch etc.

Here's a partial example of the dictionary approach
(again, doing it by hand):

```julia-repl
julia> inds = Dict((i,j)=>[] for i in 1:5 for j in 1:4);

julia> push!(inds[(1,2)], (1,1));

julia> push!(inds[(2,1)], (1,1));

julia> push!(inds[(2,2)], (1,1));

julia> append!(inds[(2,3)], [(1,2), (2,2)]); # Cell (2,3) can be scored from diagonal, or horizontal

julia> inds
Dict{Tuple{Int64, Int64}, Vector{Any}} with 20 entries:
  (1, 2) => [(1, 1)]
  (3, 1) => []
  (1, 3) => []
  (1, 4) => []
  (3, 2) => []
  (3, 3) => []
  (4, 1) => []
  (2, 1) => [(1, 1)]
  (3, 4) => []
  (4, 2) => []
  (5, 1) => []
  (2, 2) => [(1, 1)]
  (4, 3) => []
  (2, 3) => [(1, 2), (2, 2)]
  (4, 4) => []
  (2, 4) => []
  (1, 1) => []
  (5, 2) => []
  (5, 3) => []
  (5, 4) => []
```

Once this is filled out, you could recurssively follow the keys backwards.

These are not by any means the only way to accomplish this task.
if you want to try something else, by all means, do so.
For example, you might keep track of the indicies in the matrix

Just keep in mind:

1. You essentially need to build the sequences 1 character at a time
2. You need to keep track of both sequence 1 and sequence 2
3. At any time, your alignment might branch into 2 different possibilities.

#### Using custom types and recursion

Honestly, the best way to do this is probably to use custom types
and / or recurssive functions.

In particular, recurssive functions are valuable
when a problem has a tree-like structure, as this does.
Both of these topics are really beyond the scope of the course,
but if you'd like guidance on how to approach this, ask me!
