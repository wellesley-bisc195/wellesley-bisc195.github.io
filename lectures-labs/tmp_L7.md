+++
number = 7
title = ""
date = Date(2021, 06, 29)

+++

{{lecture_preamble}}

## Completing Needleman-Wunsch

We now need to add one more component to our scoring algorithm -
retracing the scoring steps to determine the alignment
or alignments that lead to the best possible score.

In the example above, there are 3 possible alignments that give the best score:
those where `seq1` is `"AAATG"` and where `seq2` is either
`"-AATG"`, `"A-ATG"`, or `"AA-TG"`.

There are 2 ways to approach this:

1. Loop back through a completed scoring matrix like the one above,
   and figure out where the score came from.
2. Modify `nwscorematrix()` to keep track of whether a given score
   came from a gap direction and/or the diagonal,
   and then return that information.

There are merits and draw-backs to each approach.
And I'll leave it to you to decide which route to follow.
I'll give some pointers for both cases,
but first we need to consider how we're going to keep track
of the alignments that we're building.

## Keeping track of a (potentially) ever-expanding group of alignments

Before you run a Needleman-Wunsch alighnment,
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

### Option 1: Re-tracing your steps

To follow this approch,
consider the example given above again:

```julia-repl
julia> nwscorematrix("AAATG", "AATG")
6×5 Matrix{Int64}:
  0  -1  -2  -3  -4
 -1   1   0  -1  -2
 -2   0   2   1   0
 -3  -1   1   1   0
 -4  -2   0   2   1
 -5  -3  -1   1   3
```

We'll always start from the lower right corner - in this case,
the `3` at index `[6,5]`.

Now, we can repeat the scoring in reverse:
which cells could the `6` have come from?
In this case, only the diagonal, so the last position in the alignment
should correspond to `G` from `seq1` and `G` from `seq2`.

It's the same for the `2` at `[5,4]` - it could only have come from the diagonal,
so `T` and `T`.

Now we have our first branch; the `1` at index `[4,3]`
could be a gap score from `[3,3]`,
or a match from `[3,2]`.
In other words, our possible alignments so far are

```
ATG
-TG
```

and

```
ATG
ATG
```

Now we need to keep track of and follow both branches...

Keep in mind that before you step through the matrix,
you cannot know how many different alignments are possible.
Your function needs to do the following:

1. Step backwards through the matrix from the lower left
2. 