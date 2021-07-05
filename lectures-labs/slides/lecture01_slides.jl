### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 4285282c-bd6b-11eb-024c-0108aa431080
using PlutoUI

# ╔═╡ e63ebc05-1503-4ba8-a470-fb5b7749f2f2
using Test

# ╔═╡ 296bafc5-fe27-436a-b096-44bb8b9a54d8
html"<button onclick='present()'>present</button>"

# ╔═╡ 068148db-6072-4a80-babb-ec00eb7ab553
md"""
# Lecture 1: Getting Started

**Kevin Bonham, PhD**\
**2021-06-08**

**`Lessons = [1,2]`**
"""

# ╔═╡ 598254c8-8dc6-4065-9d0e-837ccf061f80
md"""
## What is a computer program?"""

# ╔═╡ 9d2bc9fc-f2c6-419c-ac69-34a14fe9e1e1
function hello(x)
    return "Hello, $(x)!"
end

# ╔═╡ 215d8f14-5854-4251-a515-602862e32b1e
hello("world")

# ╔═╡ c25e2dfd-62a1-4033-bb9b-30bfa6ad0454
md"""
## What makes programming languages challenging to learn?
"""

# ╔═╡ fbf466b9-502c-4225-afea-007b891db7aa
md"- Programming languages are **literal**"

# ╔═╡ 8508a37a-b131-4cef-baa4-f9c878537f45
42 + 10

# ╔═╡ ec3df912-c678-42f0-9510-2ebbbb44d4fa
5 + "2"

# ╔═╡ dbda9c56-7928-4256-a223-4582a015f078
md"- Programming languages are **procedural**"

# ╔═╡ 5f979bec-07e3-4421-a961-a8d8b3d3fc1c
let
	foo(x) = x + 1
	foo(10)
end

# ╔═╡ 58a181c0-38e7-4db5-b8ad-13d75646a57d
let
	bar(10)
	bar(y) = y + 2
end

# ╔═╡ 6819cf44-3749-4645-9ee3-64d8f7e1dbf9
md"""
## Programs (algorithms) are just things and actions

- "Things" in computer code are data
- "Actions" in computer code are generally called "functions"
- Real life is filled with algorithms

**Question:** What are some algorithms you run in real life?"""

# ╔═╡ 62c332ac-9cf0-46b4-851f-ee072a6285c0
md"""
## What are "essential" skills?

- How do I think about writing a computer program?
- When the code I've written has an error, what steps do I take to debug it?
- How do I keep track of the code that I've written?
- How do I get help when I'm stuck?

**What are _not_ essential skills:**
- syntax specific to any programming language (even julia!)
- anything that you can google (though knowing *how* to google is!)
"""

# ╔═╡ 6ba80841-45fb-48d1-9dcb-19432471af1b
# tell me a bit about yourself, eg what are you studying, why do you want to learn programming, what's an interesting fact about you?
people = Dict(
	"Kevin" => md"""
	PhD in Immunology, but now working as a computational biologist,
	studying the human microbiome and its effect on	cognitive development in kids.
	Senior Research Scientist at Wellesley.
	
	Married to [Rachel Rynick](rachelrynick.com), have a 2 year old son (Isaiah).
	""",
	"Shelley" => md"""
	- Works with Vanja as research associate.
	- Biogeochemist working with USGS for microbes in extreme environment (eg As in Mono Lake)
	- Interested in learning about how to deal with eg sequencing data etc in computational way""",
	"Ellie" => md"""
	- rising senior
	- bio major (premed, but enjoying research)
	- internship working in lab studying JDM (juvenile muscular dermatomyocytis) using AI""",
	"Emily" => md"""
	- rising sophmore
	- born / raised in Bejing, living in CA for 8 years
	- enjoyed CS course and biology
	- Likes everything associated matcha""",
	"Jen" => md"""
	- rising sophmore interested in CS and biology
	- previously took data structures course""",
	"Anika" => md"""
	- rising Junior (biochem major / music minor)
	- Took beta (β) version of the course last summer
	- works with Kevin on computational project""",
	"Andrea" => md"""
	- rising junior (biochem major), maybe poli-sci double major
	- some experience in javascript and python
	- public health interest""",
	"Deniz" => md"""
	- rising junior
	- bio major (english minor maybe)
	- biostats course, enjoyed coding part (R)
	""",
	"Steph" => md"""
	- rising Senior in VKC lab (Vanja Klepac-Ceraj)
	- in the lab since freshman year
	- Kevin talks crazy talk
	- Psych major, originally interested in Law School, now premed.
	- From South FL, danced competitively
	- no code experience - here to learn!""",
	"Jessica" => md"""
	- non-traditional student (started in 2016)
	- self-taught a lot of medicine / biochem
	- Philosophy major (phil. of medicine / bioethics)"""
	);

# ╔═╡ cea5640e-313f-43d2-82d6-a095202d7a06
md"""
## Who are you?

$(@bind person Select([p=>p for p in keys(people)]))
"""

# ╔═╡ de3c17c1-1017-49e3-be03-608e8494f66c
md"$(people[person])"

# ╔═╡ 97c129ad-7793-4e34-8793-eb7d6c72f6cd
md"""
## Course Components

- [Zulip chat](https://bonhamlab.zulipchat.com/); all course communication will happen here.
- Free online textbook, [*Think Julia*](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html)
- [BISC 195 course website](http://wellesley-bisc195.github.io)
  - "Lessons" contain additional written content, and links to other components
- Scheduled course times (Tu/F) will be mix of "lecture" and "lab" 
  - Lectures are what we're doing now!
  - Labs will be a mix of activities, pair-programming, and chances to work on assignments
- "Assignments" are due ~ 2 / week, and are the primary source of your grade
  - Submitted / auto graded through [github classroom](https://classroom.github.com/classrooms/49307558-bisc195-summer2021)
- A "Final Project" will be designed and built in the last 2 weeks of class.

"""

# ╔═╡ 416b2a6f-4678-466c-a4b6-ba55398d2e30
md"""
## An example of what's coming

(you'll be able to do all of this in a few weeks)
"""

# ╔═╡ 4478f450-d5d6-4ac8-b917-bd91d00fdc7e
md"**What's the reverse complement of:**"

# ╔═╡ 68c93e75-0af0-4e17-9e57-68ca97e27e32
@bind seq TextField()

# ╔═╡ a82b3c96-13db-49f5-a303-1a8e0edd8246
md"""
# Lab 1 - Install stuff

In principle, you should have already done this, but life gets busy!
Before we're done here, you should have:

- If you're a windows user, installed WSL2
- installed julia and VS Code
- (optional) Mac users, if you finish other stuff, [install git](http://localhost:8080/lessons/Lesson02/#installing_git)
"""

# ╔═╡ 6602e2f2-a231-4dbb-8eae-3b4997053417
md"## Utils (you can ignore the stuff below)"

# ╔═╡ a4e9347c-6b8d-4efb-a88b-3648c83b96bb
with_terminal() do
	@testset "Some tests" begin
		@test 1+1 == 2
		@test_throws ErrorException error()
	end
end

# ╔═╡ f22330b1-d47f-4fb4-8e83-c4f4e9e89fcb
dna_complements = (
	a = 't',
	c = 'g',
	g = 'c',
	t = 'a')

# ╔═╡ 7875b4fb-6a66-48f2-930b-e9d11996b006
complement(base::Symbol) = uppercase(dna_complements[base])

# ╔═╡ 4dd73001-625d-4a7e-9506-579f55790780
complement(base::Char) = complement(Symbol(lowercase(base)))

# ╔═╡ 54d41a99-2d71-4764-a0bf-1281c98e92a0
complement(sequence::AbstractString) = string((complement(sequence[i]) for i in eachindex(sequence))...)

# ╔═╡ 619e2809-c36c-41ee-8062-9dae79c228db
reverse_complement(sequence) = reverse(complement(sequence))

# ╔═╡ 1a329879-a2f4-404b-b856-e263a62e2ba7
reverse_complement(seq)

# ╔═╡ Cell order:
# ╠═296bafc5-fe27-436a-b096-44bb8b9a54d8
# ╠═068148db-6072-4a80-babb-ec00eb7ab553
# ╟─598254c8-8dc6-4065-9d0e-837ccf061f80
# ╠═9d2bc9fc-f2c6-419c-ac69-34a14fe9e1e1
# ╠═215d8f14-5854-4251-a515-602862e32b1e
# ╟─c25e2dfd-62a1-4033-bb9b-30bfa6ad0454
# ╟─fbf466b9-502c-4225-afea-007b891db7aa
# ╠═8508a37a-b131-4cef-baa4-f9c878537f45
# ╠═ec3df912-c678-42f0-9510-2ebbbb44d4fa
# ╟─dbda9c56-7928-4256-a223-4582a015f078
# ╠═5f979bec-07e3-4421-a961-a8d8b3d3fc1c
# ╠═58a181c0-38e7-4db5-b8ad-13d75646a57d
# ╟─6819cf44-3749-4645-9ee3-64d8f7e1dbf9
# ╟─62c332ac-9cf0-46b4-851f-ee072a6285c0
# ╟─cea5640e-313f-43d2-82d6-a095202d7a06
# ╟─de3c17c1-1017-49e3-be03-608e8494f66c
# ╟─6ba80841-45fb-48d1-9dcb-19432471af1b
# ╟─97c129ad-7793-4e34-8793-eb7d6c72f6cd
# ╟─416b2a6f-4678-466c-a4b6-ba55398d2e30
# ╟─4478f450-d5d6-4ac8-b917-bd91d00fdc7e
# ╟─68c93e75-0af0-4e17-9e57-68ca97e27e32
# ╟─1a329879-a2f4-404b-b856-e263a62e2ba7
# ╟─a82b3c96-13db-49f5-a303-1a8e0edd8246
# ╟─6602e2f2-a231-4dbb-8eae-3b4997053417
# ╠═4285282c-bd6b-11eb-024c-0108aa431080
# ╠═e63ebc05-1503-4ba8-a470-fb5b7749f2f2
# ╠═a4e9347c-6b8d-4efb-a88b-3648c83b96bb
# ╠═f22330b1-d47f-4fb4-8e83-c4f4e9e89fcb
# ╠═7875b4fb-6a66-48f2-930b-e9d11996b006
# ╠═4dd73001-625d-4a7e-9506-579f55790780
# ╠═54d41a99-2d71-4764-a0bf-1281c98e92a0
# ╠═619e2809-c36c-41ee-8062-9dae79c228db
