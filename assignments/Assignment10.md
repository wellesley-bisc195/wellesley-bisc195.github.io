+++
number = 10
title = "Final Project"
release = Date(2021,07,05)
due_date = Date(2021,07,23)
+++

{{assignment_preamble}}

## Components

The final project is worth 30 points total (30% of your overall grade),
and will be made up of of several parts.

1. Analysis plan - 5pts
   - Due Monday, July 12
2. Code repository - 15 pts
   - First draft due Sunday, July 18
   - Final draft due Fri, July 23
3. Analysis repository - 10 pts
   - First draft due Sunday, July 18
   - Final draft due Fri, July 23

If you intend to do an alternative analysis than the one described below,
your proposal is due Friday, July 9th.
## Deadline policies

- Late submissions will be docked 10% of points per 24 hours late,
  up to 40% of the total.
- Final projects submitted more than 4 days late
  will be scored based on the first draft
  so that grades can be turned in on time.
- On-time first drafts will be reviewed by mid day on Tuesday, July 20th.
  I will make every effort to review late submissions,
  but I cannot guarantee that reviews will be timely.

## Rubrics

### Analysis Plan - 5 pts

In assignments 7-9,
you started to create a bioinformatics package to do some sequence analysis,
and to create an analysis repository to analyze Sars-CoV-related genomes.

So far, you've calculated and plotted sequence lengths and GC content,
and calculated kmer composition.
Choose 2 additional sequence features to analyze.
You might use your `AlignmentAlgorithms` code to create
and alternate distance metric,
or compare and plot kmer compositions from different geographical regions,
or accross time.

Each analysis should comprise

1. Implementation and application of functions written in julia
   to generate metrics.
2. Tables and / or plots that summarize the findings.
3. Descriptions of the code, how it's used, and the results obtained.

For your analysis plan,
create a file called `analysis_plan.md` in the root of your analysis repository,
and write ~300-600 words describing what you plan to do.
Use markdown syntax, including headers and bulleted or numbered lists.
You should explain

1. What analysis you plan to do
2. What functions you will use, including any new functions
   that you need to write
3. How you intend to display the results (eg what will you plot,
   or how will you summarize the results)

It's OK if you're not 100% sure how to implement every part of your analysis,
I can help!
But your intentions, and a plan of action should be clear.

Your analysis plan is considered submitted
when you have pushed the file to github,
and opened an issue tagging Kevin and noting the specific commit.

#### Excellent - full credit (5 pts)

- Two proposed analyses are clear and concise,
  and contain details including descriptions of functions needed,
  plots or other display items intended,
  and a clear roadmap for how to generate them
- Markdown formatting is used effectively to organize into subsections,
  emphasize important points,
  and provide concise descriptions in lists
- Assignment is submitted on time

#### Good - partial credit (4 pts)

- Two proposed analyses are clear and concise, but are missing some details
  of functions needed, plots or other display items intended
- Roadmap for generating intended analyses is clear,
  but missing some steps, or is complete but not entirely clear.
- Markdown formatting is used, but not as effectively as possible
- Assignment is submitted on time

#### Needs work - partial credit (3 or fewer points)

- Only 1 analysis proposed, or descriptions of analyses are incomplete
- Descriptions of functions needed and plots or other display items
  are unclear or incomplete
- Markdown formatting is used sparingly or not at all.
- Assignment is submitted late, or incorrectly.

### Code Repository (15 points)

Using the same repository that you began with [Assignment07](assignments/Assignment07),
you will create a julia package containing the functions required
for implementing your analysis plan.

Functions that you intend to use in the analysis should be exported,
documented in docstrings, and tested in `test/runtests.jl`.
Throughout this course, we've been practicing how to write code,
read and write documentation, and tests.
This is the chance to show off what you've learned!

Functions should be well-written,
using type signatures where appropriate
(eg if using different methods for `String`s and `Char`s).
Function, conditional, and loop blocks should be properly inedented.
If the purpose of some code might be unclear,
use comments to describe what it does.

Docstrings should contain a signature describing what arguments are used, eg

```julia
"""
    my_func(foo, bar; some_kwarg)

Here's the description...
"""
function my_func(foo, bar; some_kwarg=3)
    # ...
end
```

Docstrings should provide clear explanations of the intent of the function,
as well as examples of proper inputs and expected outputs.

The automated tests for your project should include tests
for all exported functions, for as many possible inputs as possible.
When you have conditionals in a function, all branches of the conditional
should be tested separately.
One goal of automated tests is to make sure that if changes are made later,
any breakage will be caught.

Preliminary scores will be given based on first draft if completed on time,
but final scores will only consider the final submission.
Submission is complete when a `v0.1.x` release is tagged and Kevin is notified.

#### Excellent - Full credit (15 points)

- All functions needed for analysis are exported, documented, and tested.
- Function code is clean and clear, with proper indentation used throughout.
  Inline comments are used for complicated bits of code.
- All exported functions are documented, and docstrings
  include function signatures, clear descriptions of arguments, and usage examples.
- All exported functions have automated tests for multiple inputs,
  testing all conditional branches.
- All tests pass.

#### Good - Partial credit (12-14 points)

- All functions needed for analysis are exported, documented, and tested.
- Function code is clear, with proper indentation used in most places.
- All exported functions are documented, though descriptions may be unclear,
  and some may lack signatures or usage examples.
- All exported functions have automated tests for inputs,
  but some are missing some possible inputs, or not all conditional branches are tested.
- All tests pass

#### Needs work - Partial credit (11 or fewer points)

- Some functions lack documentation or tests
- Function code is poorly formatted, lacking appropriate indentation
- Docstrings lack signatures or usage examples
- Many function inputs or conditional branches are not tested.
- Not all tests pass.

### Analysis repository (10 points)

Your analysis repository was started in [Assignment08](assignments/Assignment08),
and should include code notebooks (in Pluto or markdown form)
that detail your analyses.

Separate analyses should be contained in separate notebooks,
and should include all required setup code,
as well as the code required to perform the analysis
and generate plots and other display items.

A narrative of how the analysis was performed, writted in markdown,
should accompany blocks of code so that a reader unfamiliar with the code base
can still follow what's being done, and why.
Merely descriptive comments are not sufficient. Eg, you can write

> I wanted to look at the GC content, since this is an easy-to-calculate
> though crude measure of how related two sequences are related.
```julia-repl
julia> gc_content(seq1)
0.3

julia> gc_content(seq2)
0.32
```
> As you can see, these two sequences are pretty close.

Not just,

> Next, I calculated the GC content

```julia-repl
julia> gc_content(seq1)
0.3

julia> gc_content(seq2)
0.32
```

You may include things that you tried that didn't work alongside
the completed analysis.

Preliminary scores will be given based on first draft if completed on time,
but final scores will only consider the final submission.
Submission is complete when a `v0.1.x` release is tagged and Kevin is notified.

#### Excellent - Full credit (10 points)

- Analysis notebooks are organized and clearly detail the analyses performed.
- Narrative is descriptive rather than technical.
  Problems or errors encountered are described, along with solutions if applicable.
- Plots and other display items are described, and well-formatted.

#### Good - Partial credit (8-9 points)

- Analysis notebooks are organized, but lack some detail.
- Mostly written as narrative, but some descriptions are merely technical.
- Plots and other display items are described, but not well-formatted, or unclear.

#### Needs work - Partial credit (7 or fewer points)

- Analysis notebooks are not well organized and lack detail.
- Many code blocks lack explanation, or have only technical explanation
  rather than narrative description.
- Plots and other display items are presented without description,
  are poorly formatted, and unclear.
