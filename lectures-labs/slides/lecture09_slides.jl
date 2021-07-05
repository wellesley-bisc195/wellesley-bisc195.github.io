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

# ╔═╡ b87b43c0-b4a6-4867-a158-aa16047d5d6e
import Pkg; Pkg.add("BioAlignments")

# ╔═╡ 6286b054-dda6-11eb-3316-69264998f338
using Plots

# ╔═╡ f623ea54-6556-4064-9885-0e95ef8b25cb
using Distributions

# ╔═╡ 5382e1ff-9f19-4a34-84a0-a3e853819211
using PlutoUI

# ╔═╡ 2254fcb8-2958-471f-8804-74ffa494c96d
html"<button onclick='present()'>present</button>"

# ╔═╡ f6d11e7a-e52e-49f9-bb83-fb80bed608a6
md"""
# Lecture 9 - Packages and Plots

**Kevin Bonham, PhD**\
**2021-06-08**
"""

# ╔═╡ d9697ced-b183-40af-b1b9-034d1f37e37f
md"""
## Packages enable more powerful code reuse

- Loops and functions are examples of code reuse, but have limited portability
- Packages enable related functions and types to be installed and used together
- Includes information about dependencies - packages are built on other packages
- Packages for everything from new data structures to plotting and stats to physics simulation
"""

# ╔═╡ f499caea-c901-4869-a24b-481b4bbc5c37


# ╔═╡ 3d46aa1a-b238-4b24-9beb-e544ec131191
md"""
Mean: $(@bind μ Slider(-3:0.1:3, default=0, show_value=true)) 

Error: $(@bind σ Slider(0.1:0.1:3, default=1, show_value=true))

N samples: $(@bind n_samples Slider(010:10:1000, default=100, show_value=true))"""

# ╔═╡ 67c2ed4b-3f1a-4836-a458-74b6cc13d2ef
let
	rand_numbers = rand(Normal(μ, σ), n_samples)
	histogram(rand_numbers, 
			xlims=(-5, 5),
			ylims=(0,200),
			primary=false)
	vline!([μ], label="Mean (expected)")
	vline!([mean(rand_numbers)], label="Mean (actual)")
	title!("A Normal Distribution")
end

# ╔═╡ 677d5800-e11a-4894-b38a-00fb44bcd5cb
md"""
α: $(@bind α Slider(0.1:0.1:5, default=1, show_value=true)) 

β: $(@bind β Slider(0.1:0.1:5, default=1, show_value=true))
"""

# ╔═╡ 2f4df2ba-2447-4fe9-8971-fe6191bb330d
let
	histogram(rand(Beta(α, β), 1000),
		xlims = (0,1),
		ylims=(0,800),
		primary=false)
	title!("A Beta Distribution")
end

# ╔═╡ Cell order:
# ╟─2254fcb8-2958-471f-8804-74ffa494c96d
# ╟─f6d11e7a-e52e-49f9-bb83-fb80bed608a6
# ╟─d9697ced-b183-40af-b1b9-034d1f37e37f
# ╠═f499caea-c901-4869-a24b-481b4bbc5c37
# ╠═6286b054-dda6-11eb-3316-69264998f338
# ╠═f623ea54-6556-4064-9885-0e95ef8b25cb
# ╟─3d46aa1a-b238-4b24-9beb-e544ec131191
# ╠═67c2ed4b-3f1a-4836-a458-74b6cc13d2ef
# ╟─677d5800-e11a-4894-b38a-00fb44bcd5cb
# ╠═2f4df2ba-2447-4fe9-8971-fe6191bb330d
# ╠═5382e1ff-9f19-4a34-84a0-a3e853819211
# ╠═b87b43c0-b4a6-4867-a158-aa16047d5d6e
