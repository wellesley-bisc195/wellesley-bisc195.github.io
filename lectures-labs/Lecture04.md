+++
number = 4
title = "Free play"
date = Date(2021, 06, 18)
+++

{{lecture_preamble}}

@@colbox-blue
@@title
**Note**
@@
Kevin is out of town, so there will be no lecture today.
Use class time to work on today's lab, or get caught up on assignments.
The lecture Zoom link is open if you want to meet up with fellow students
to work together on labs, or ask eachother questions.
@@

## Lab 4 - Needleman-Wunsch Aligner, Part 2

In the [last lab](../Lecture03/#lab_3_-_needleman-wunsch_aligner_part_1),
we built some scoring functions for a Needleman-wunsch alighnment algorithm.
Today, we're going to build a function that will build and score
an alignment matrix.

@@colbox-blue
@@title
**Note**
@@
This lab will be quite challenging if you have not yet completed lesson 5,
where you learn about writing loops.
At minimum, you should have read the chapters of the book assigned for lesson 5.
@@

### Continuing from Lab 3 - submission guidelines

You should have completed Lab 3 before you get stared on Lab 4.
This lab will require a separate pull request from Lab 3,
and there are several ways to do this,
depending on how you completed Lab 3.

If you submitted your own PR for Lab 3
and would like to do the same for Lab 4,
or you submitted a PR with a partner and would like to continue to work together,
this is the easiest case.
Simply check out a new branch from where you left off (`git checkout -b lab4`),
push it to github (`git push -u origin lab4`)

If you previously worked with a partner, and want to 

### Intro to Matrix - a 2D array

A matrix is a 2 dimensional "array" -
you'll learn more about arrays in [Lesson 6](/lessons/Lesson05),
but for now, think of it like a table in excel or google sheets
with rows and columns.

The _first_ dimension of a `Matrix` is the row number,
and the _second_ dimension is the column number.
you can access the value of a given position using "indexing" -
in julia, the syntax for that accessing row $i$ and column $j$ from matrix $M$
is `M[i, j]`.

For example, the following is a matrix with 3 columns and 4 rows
(no need to understand the first line):

```julia-repl
julia> M = collect(reshape(1:12, 4, 3))
4×3 Matrix{Int64}:
 1  5   9
 2  6  10
 3  7  11
 4  8  12
 ```

If I want to access the 3rd row, 2nd column,
I can do:

```julia-repl
julia> M[3,2]
7
```

You can also re-assign the value at a given position,
using the same assignment syntax as for variables,
eg:

```julia-repl
julia> M[3,2] = 42
42

julia> m # note where the 7 used to be
4×3 Matrix{Int64}:
 1   5   9
 2   6  10
 3  42  11
 4   8  12
```

The last thing you need to know is that you can create a matrix
with $c$ columns and $r$ rows that's filled with zeros of type $T$
using `zeros(T, r, c)`, eg

```julia-repl
julia> zeros(Int, 4,3)
4×3 Matrix{Int64}:
 0  0  0
 0  0  0
 0  0  0
 0  0  0
```

OK, let's get started!

### Step 1 - Make a matrix

First, let's write a function that sets up an alignment matrix
for our NW aligner.

@@colbox-orange
@@title
Checking Question
@@
Given two sequences, $s_1$ and $s_2$,
with lengths $l_1$ and $l_2$,
what size should the resulting scoring matrix be?

Answer below[^cq1ans]
@@

Write a function called `nwsetupmatrix()` that takes 2 sequences
and generates a scoring matrix of the correct size.
The matrix should start out being filled with zeros.
Don't forget to add it to your package exports in `src/BISC195Labs.jl`!

Add the following to `test/runtests.jl` in your BISC195Labs repo:

```julia
@testset "Scoring matrix setup" begin
    m = nwsetupmatrix("AATT", "AAGTT")
    
    @test m isa Matrix
    @test size(m, 1) == 5
    @test size(m, 2) == 6
    @test all(==(0), m)
end
```

This testset should pass if you made `nwsetupmatrix()` correctly.

### Step 2 - More Matrix setup

Actually, you can do more during the setup phase
without actually comparing the sequences.

1. Position $M_{(1,1)}$ is always $0$
2. Positions $M_{(1,j)}$ for all $j > 1$ are $(j-1)g$, where $g$ is the gap score
3. Positions $M_{(i,1)}$ for all $i > 1$ are $(i-1)g$, where $g$ is the gap score

Another way to say that is that you can fill the first row and column
with the gap score times the row or column index minus 1.

For example, if your gap score is $2$, and you have a $4\times5$ matrix,
you can set up your matrix like this:

```julia-repl
julia> M
4×5 Matrix{Int64}:
  0  -2  -4  -6  -8
 -2   0   0   0   0
 -4   0   0   0   0
 -6   0   0   0   0

julia> M[1,1]
0

julia> M[1,2]
-2

julia> M[1,5]
-8
```

Now, add a keyword argument to `nwsetupmatrix()`
that allows you to give it a gap score, with a default of `-1`.
Add code that fills in the scores for the first row and column.

All of your tests except the last one should still work, except for the last one.
Here are some more:

```julia
@testset "Scoring matrix setup" begin
    m = nwsetupmatrix("AATT", "AAGTT")
    
    @test m isa Matrix
    @test size(m, 1) == 5
    @test size(m, 2) == 6
    # @test all(==(0), m) # this no longer works

    @test m[1,1] == 0

    # I wrote these next two in a way that's slightly opaque, since writing it in a clear way
    # would make it obvious how to write the function in the first place.
    # If you want to know how it works, ask me on Zulip,
    # or if you want to investigate yourself, break it down into individual expressions
    @test all(m[2:end,1] .== (-1 .* (1:(size(m,1)-1)))) # test first column
    @test all(m[1,2:end] .== (-1 .* (1:(size(m,2)-1)))) # test first row

    m2 = nwsetupmatrix("AATT", "AAGTT"; gap=-2)
    
    @test m2 isa Matrix
    @test size(m2, 1) == 5
    @test size(m2, 2) == 6

    @test m2[1,1] == 0
    @test all(m2[2:end,1] .== (-2 .* (1:(size(m2,1)-1)))) # test first column
    @test all(m2[1,2:end] .== (-2 .* (1:(size(m2,2)-1)))) # test first row
end
```

### Step 3 - Score the matrix

Now that you can set up the matrix, it's time to score it.
Write a function that takes two sequences,
and uses keyword arguments to set the `match`, `mismatch`, and `gap` scores,
and then scores the remaining cells.

A couple of pointers to get you started:

1. If your matrix is $m$, your row index is $i$, and your column index is $j$,
   recall that the score for a cell is the largest of:
   1. the score coming from above it (a gap), that is `m[i-1, j]`
   2. the score coming from the left (a gap), that is `m[i, j-1]`
   3. the score coming from the diagonal (a match or mismatch), that is `m[i-1, j-1]`
2. The `max()` function takes any number of arguments, and returns the largest.
   
   ```julia-repl
   julia> max(1,5,3,6,-1,5)
       6
   ```
3. To get the letter of a `String` at a given position, you can index it like a vector.
   That is, the 3rd letter of `s` can be pulled out with `s[3]`.
   Just keep in mind that the 3rd letter of sequence1 is actually the 4th row.
   Keep your indices straight! "Off-by-one" errors are pretty common in programming.
4. For now, don't bother to keep track of where a given score came from,
   we'll deal with that in the next lab.

I'll get it started for you:

```julia
function nwscorematrix(seq1, seq2; match=1, mismatch=-1, gap=-1)
    scoremat = nwsetupmatrix(seq1, seq2; gap=gap)
    for i in 2:size(scoremat, 1) # iterate through row indices
        for j in 2:size(scoremat, 2) # iterate through column indices
            @info "scoring Row $i, Column $j"
            # your code here ... 
        end
    end
    return scoremat
end
```

Write a test to see if you get the same scoring matrix
for the sequences in the youtube video from the last lecture.

```
julia> nwscorematrix("ACGAT", "AGGT")
6×5 Matrix{Int64}:
  0  -1  -2  -3  -4
 -1   1   0  -1  -2
 -2   0   0  -1  -2
 -3  -1   1   1   0
 -4  -2   0   0   0
 -5  -3  -1  -1   1
```

[^cq1ans]: The matrix should be $(l_1 + 1) \times (l_2 + 1)$. Note that it doesn't matter which sequence consititutes the rows, and which the columns, but be consistent! Since in julia dimension 1 is the row index, I suggest making $s_1$ be the vertical.