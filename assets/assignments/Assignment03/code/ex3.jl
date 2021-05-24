# This file was generated, do not modify it. # hide
"""
    base_type(base)

Determines whether a base is a purine (A or G) or pyrimidine (T or C),
and returns a `String`.

Examples
≡≡≡≡≡≡≡≡≡≡

    julia> base_type("G")
    "purine"

    julia> base_type('C')
    "pyrimidine"

    julia> base_type('Z')
    Error: "Base Z not supported"

    julia> x = base_type('A'); println(x)
    purine
"""
function base_type(base)
    # Note: this is different than the `base_type()` we defined in the lesson.
    # Here, we want a fruitful function that returns the value rather than `print`ing it.
    # Also, there's no need to re-write the logic. If your `ispurine` / `ispyrimidine` functions work,
    # you can use them here.
end