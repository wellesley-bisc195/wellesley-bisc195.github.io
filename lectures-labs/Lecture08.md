+++
number = 8
title = "Finishing alignments"
date = Date(2021, 7, 2)
+++

{{lecture_preamble}}

## Continuing from Lab07

### Alignment tracing for NW and SW

- start from $M_{(i,j)}$ where $i$ and $j$ are
  - the last indices in 1st and 2nd dimension for NW
  - the indices for the matrix with the maximum score in SW
- Check the score from 
  1. $M_{(i,j-1)}$ (cell to the left), a gap score
  2. $M_{(i-1,j)}$ (cell above), a gap score
  3. $M_{(i-1,j-1)}$ (cell from diagonal), a match or mismatch 
- If any match your current cell, push correct characters to alignments
  1. push gap to `seq1`, character at $j$ to `seq2`
  2. push character at $i$ to `seq1`, gap to `seq2`
  3. push character at $i$ to `seq1`, character at $j$ to =seq2=
- update indices

### Special considerations

- Be mindful of what happens when you hit the first row or first column
  - $i-1$ or $j-1$ may throw bounds error
- When should your loop stop?
  - It will be different for Needleman-Wunsch than for Smith-Waterman
