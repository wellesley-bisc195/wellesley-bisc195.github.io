+++
number = 6
title = "Smith-Waterman"
date = Date(2021, 06, 24)
+++

{{lecture_preamble}}

## Smith-Waterman alignment

@@colbox-blue
@@title
Note
@@
I changed the name of the repository and the module
from `BISC195Labs` to `AlignmentAlgorithms`.
Sorry for any confusion this causes.
@@

After completing labs 3-5,
you should now have the functionality
to take 2 biological sequences,
construct an appropriate scoring matrix,
and score it.

```julia-repl
julia> using AlignmentAlgorithms

julia> nwscorematrix("AAATG", "AATG")
6×5 Matrix{Int64}:
  0  -1  -2  -3  -4
 -1   1   0  -1  -2
 -2   0   2   1   0
 -3  -1   1   1   0
 -4  -2   0   2   1
 -5  -3  -1   1   3

 julia> nwscorematrix("AAATG", "AATG"; gap=-2, match=2)
6×5 Matrix{Int64}:
   0  -2  -4  -6  -8
  -2   2   0  -2  -4
  -4   0   4   2   0
  -6  -2   2   3   1
  -8  -4   0   4   2
 -10  -6  -2   2   6
 ```

Before we get to the task of actually constructing our alignments,
let's take a look at another alignment - [Smith-Waterman](https://en.wikipedia.org/wiki/Smith%E2%80%93Waterman_algorithm#Example).

## Smith Waterman for local alignment

Whereas Needleman-Wunsch is a "global" alignment algorithm,
that attempts to align the entire length of two sequences,
Smith-Waterman is a "local" alignment algorithm,
which can find regions of similarity nested within sequences
that are quite dissimilar overall.

SW takes a similar approach to NW, in that a scoring matrix is used
to follow matches, mismatches, and gaps,
with options for different scoring systems.
The primary difference is that in SW, there are no negative scores
allowed in any cell of the matrix.
If a cell's best score would be negative, a zero is added instead.

To find the best local alignment,
the highest score in the matrix is found,
and then followed backward along its scoring path
until a 0 is reached.
Check out this animation from wikipedia:

![sw gif](https://upload.wikimedia.org/wikipedia/commons/9/92/Smith-Waterman-Algorithm-Example-En.gif)

## Your task

Add new functions to your lab repository
to build a Smith-Waterman scoring matrix.

If you add the following test set to your `test/runtests.jl`,
they should pass:

```julia
@testset "Lab06" begin
    scoremat = swscorematrix("AAACCCGGG","TTTCCCAAA")
    @test maximum(swscorematrix("AAACCCGGG","TTTCCCAAA")) == 3
    @test maximum(swscorematrix("AAACCCGGG","TTTCCCAAA"; match=2)) == 6
    @test maximum(swscorematrix("AAACCCGGG","TTTCCCAAA"; gap=-2)) == 3
    @test maximum(swscorematrix("AAACCCGGG","TTTCCCAAA"; mismatch=-2)) == 3

    @test swscorematrix("GGTTGACTA", "TGTTACGG"; match=3, mismatch=-3, gap=-2) ==
        [0  0  0  0  0   0   0   0  0
         0  0  3  1  0   0   0   3  3
         0  0  3  1  0   0   0   3  6
         0  3  1  6  4   2   0   1  4
         0  3  1  4  9   7   5   3  2
         0  1  6  4  7   6   4   8  6
         0  0  4  3  5  10   8   6  5
         0  0  2  1  3   8  13  11  9
         0  3  1  5  4   6  11  10  8
         0  1  0  3  2   7   9   8  7]
end
```