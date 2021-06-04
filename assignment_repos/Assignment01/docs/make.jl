using Assignment01
using Documenter

makedocs(;
    modules=[Assignment01],
    authors="Kevin Bonham, PhD <kbonham@wellesley.edu>",
    repo="https://github.com/wellesley-bisc195/Assignment01.jl/blob/{commit}{path}#L{line}",
    sitename="Assignment01.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://wellesley-bisc195.github.io/Assignment01.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/wellesley-bisc195/Assignment01.jl",
)
