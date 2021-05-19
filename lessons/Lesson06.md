+++
number = 6
title = "Arrays"
date = Date(2021,06,22)
assignments = [5]
chapters = [8, 10]
concepts = [
    "Compare and contrast `Vector`, `Matrix`, and `Tuple` types for storing ordered data",
    "Differentiate between scalar and vector properties of `String`s",
    "Explain the uses and limitations of mutable and immutable types",
    "Recognize when to use copies or references to data"
]
skills = [
    "Solve bugs that occur from attempting to access keys or indexes that don't exist",
    "Initialize and grow Vectors of different types",
    "Use indexes, ranges, and loops to access subsets of data",
    "Use string joining and interpolation to compose complex strings"
]
+++

{{lesson_preamble}}
## String as Array

After reading chapters 8 and 10,
you might have noticed that `String`s act an awful lot like 1D `Array`s (`Vector`s).

Both `String`s and `Vector`s:

1. are ordered collections (`String`s are collections of `Char`, `Vector`s can have any type)
2. can be indexed and sliced

There are many differences, but chief among them is that `Vector`s are "mutable";
that is, we can change the vector by changing individual elements,
adding things, or removing things. 

```julia-repl
julia> v = collect(2:2:10)
5-element Vector{Int64}:
  2
  4
  6
  8
 10

julia> push!(v, 42);

julia> pushfirst!(v, -1);

julia> v
7-element Vector{Int64}:
 -1
  2
  4
  6
  8
 10
 42

julia> deleteat!(v, 1:2:7);

julia> v
3-element Vector{Int64}:
  2
  6
 10
```

`String`s, by contrast, are *immutable*.
This might not be obvious,
since you can do things like

```julia
s = "a string"
s = s * " " * s
```

It seems like `s` has changed,
but it has not changed by altering the actual object -
instead, we constructed an **entirely new string**
and just reassigned `s` to the new `String`.

@@colbox-orange
@@title
Checking Questions
@@

1. Assign an empty vector (`[]`) to the variable `v1`,
    then try to `push!` an `Int64`, `Float64`, and `String` to it.
    What is the `typeof` the `Vector`?
2. Assign `[1.2, 3, 4]` to the variable `v2`.
    What is the type of the second elementt (`v2[2]`)?
    Is that what you expected?
3. Use `push!()` to add the integer `5` to the vector `v2`.
    What is the type of `v2[4]`?
4. Use `push!()` to add the `String` `"6"` to the vector `v2`.
    What happens?
@@


`String`s themselves are not `Vector`s,
but we can use `Vector`s of `Char`s
to act like mutable `String`s.

```julia
julia> vc = collect("Collect makes vector")
20-element Vector{Char}:
 'C': ASCII/Unicode U+0043 (category Lu: Letter, uppercase)
 'o': ASCII/Unicode U+006F (category Ll: Letter, lowercase)
 'l': ASCII/Unicode U+006C (category Ll: Letter, lowercase)
 'l': ASCII/Unicode U+006C (category Ll: Letter, lowercase)
 'e': ASCII/Unicode U+0065 (category Ll: Letter, lowercase)
 'c': ASCII/Unicode U+0063 (category Ll: Letter, lowercase)
 't': ASCII/Unicode U+0074 (category Ll: Letter, lowercase)
 ' ': ASCII/Unicode U+0020 (category Zs: Separator, space)
 'm': ASCII/Unicode U+006D (category Ll: Letter, lowercase)
 'a': ASCII/Unicode U+0061 (category Ll: Letter, lowercase)
 'k': ASCII/Unicode U+006B (category Ll: Letter, lowercase)
 'e': ASCII/Unicode U+0065 (category Ll: Letter, lowercase)
 's': ASCII/Unicode U+0073 (category Ll: Letter, lowercase)
 ' ': ASCII/Unicode U+0020 (category Zs: Separator, space)
 'v': ASCII/Unicode U+0076 (category Ll: Letter, lowercase)
 'e': ASCII/Unicode U+0065 (category Ll: Letter, lowercase)
 'c': ASCII/Unicode U+0063 (category Ll: Letter, lowercase)
 't': ASCII/Unicode U+0074 (category Ll: Letter, lowercase)
 'o': ASCII/Unicode U+006F (category Ll: Letter, lowercase)
 'r': ASCII/Unicode U+0072 (category Ll: Letter, lowercase)

julia> push!(vc, 's');

julia> join(vc)
"Collect makes vectors"
```

The `join()` function takes a vector of `String`s or `Char`s
and creates a new string.

@@colbox-green
@@title
Tip
@@

Remember that you can use the help REPL (press `?` at the REPL)
to view the docstring of `join()`.
@@

The `join()` function can also take *optional* arguments
that can put a `String` in between each thing that's `join()`ed,

```julia-repl
julia> join(["I", "love", "the", "julia", "language!"], " 👏 ")
"I 👏 love 👏 the 👏 julia 👏 language!"
```

and something different between the last two values

```julia
julia> join(["Head", "shoulders", "knees", "toes"], ", ", ", and ")
"Head, shoulders, knees, and toes"
```

## Aliasing

Make sure you've read [the section on "aliasing"](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html#_aliasing)
in _Think Julia_
prior to answering the following questions.
Even if you already read it, it's worth reading again -
this is a constant source of hard-to-find bugs.

@@colbox-orange
@@title
 "Checking questions"
@@

For each of the following questions,
first try to predict the answer,
then check your answer at the REPL.
If you were wrong, try to explain the correct answer.

1. The follwing code assigns 3 variables (`a`, `b`, and `c`) to the float `6.02e24`,
    then reassigns one of them (`a`) to the float `3.14`.

```julia-repl
julia> a = b = c = 6.02e24
6.02e24

julia> a = 3.14
3.14
```

    What is the value of `b`?

2. Can you assign `c` to an `Int64`?
3. The following code assigns 3 variables (`u`, `v`, `w`) to an empty Integer vector,
    then `push!`es the integer `12` to one of them (`u`)

```julia-repl
julia> u = v = w = Int64[]
0-element Array{Int64,1}

julia> push!(u, 12)
1-element Array{Int64,1}:
    12
```

    What is the value of `v`?

4. Can you `push!()` a `Float64` to `w`?
5. Which of the following have the same *type* as `m`
   if `m = [1, 4]`?

   - `n = [5,4,3,2,1]`
   - `o = Int64[]`
   - `p = ["2", "1"]`
   - `q = [1.2, 3.4]`

    Hint: you can check by doing eg `n isa (typeof(m))`
@@

## Maps and filters revisited

In [chapter 10 of _Think Julia_](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html#_map_filter_and_reduce),
you are introduced to the concept of "map" and "filter" functions,
which apply a function to each element of a collection,
or return only elements that meet a condition respectively.

In the chapter, the examples shown are of
hand-written map and filter functions written with loops,
but these pattterns are so useful that there are
`map()` and `filter()` functions,
each of which take a function as the first argument,
and a collection as the second argument.

For example,

```julia-repl
julia> function add3(x)
           return x + 3
       end
add3 (generic function with 1 method)

julia> v = map(add3, [1,2,3,4])
4-element Vector{Int64}:
 4
 5
 6
 7
```

This is the same as

```julia
v = Int64[]

for x in [1,2,3,4]
    push!(v, add3(x))
end
```

This type of `map()` returns a copy of the vector,
so the original data will not be altered,
but you can also use `map!()` with the same syntax
to mutate the underlying vector.

Similarly, one can use `filter()` (or, to mutate, `filter!()`)
to perform a filtering function.
In this case, the function passed as the first argument
must be a boolean function
(anything that returns `true` will be kept).

```julia-repl
julia> original = [3.14, 8.5, 25.3, 1.0]
4-element Vector{Float64}:
  3.14
  8.5
 25.3
  1.0

julia> function lessthan5(x)
           return x < 5
       end
lessthan5 (generic function with 1 method)

julia> newv = filter(lessthan5, original)
```

is the same as

```julia
newv = Float64[]

for x in original
    if lessthan5(x)
        push!(newv, x)
    end
end
```

