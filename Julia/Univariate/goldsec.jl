# BSD 3-Clause License
# Copyright (c) 2022, Langyan
# All rights reserved.

include("../util/utilities.jl")

""" # Golden Section Algorithm
	_GoldenSection_(optfunc, interval::AbstractVector, eps=1e-4) -> Optim_res

Optimize a function using Golden Section Algorithm

# Parameters
## arguments
* `optfunc::Function` - function to be optimized
* `interval::AbstractVector` - the interval to apply GS algorithm

## keyword arguments
* `eps` - threshold to end the optimization (prescrided accuracy) (default 1e-4)

# Examples
```julia
julia> optfunc(x) = x^2 + 4 * x - 4;

julia> _GoldenSection_(optfunc, [-10,10], 1e-8)
Optimization Results
-----------------------------------
-----------------------------------
Algorithm: Golden Section
Minimum point: -1.9999999770027157
Minimum: -8.0
iterations: 45
Optim_res(-1.9999999770027157, -8.0, 45)

julia> _GoldenSection_(x -> 2x^2 + 3x + 1, [-10,10], 1e-8)
Optimization Results
-----------------------------------
-----------------------------------
Algorithm: Golden Section
Minimum point: -0.7499999977519514
Minimum: -0.12500000000000022
iterations: 45
Optim_res(-0.7499999977519514, -0.12500000000000022, 45)

```
"""
function _GoldenSection_(optfunc::Function, interval::AbstractVector, eps=1e-4)
	r = (sqrt(5) - 1) / 2
	# containers
	a, b = interval[1], interval[2]
	L = b - a
	i = 0
	λ₁, λ₂ = a + r^2 * L, a + r * L
	F₁, F₂ = optfunc(λ₁), optfunc(λ₂)

	# initialize result containers
	minimum = nothing
	λ = nothing

	# update containers
	while true
		if F₁ < F₂
			b = λ₂; λ₂ = λ₁; F₂ = F₁; L = r * L; λ₁ = a + r^2 * L; F₁ = optfunc(λ₁)
		else
			a = λ₁; λ₁ = λ₂; F₁ = F₂; L = r * L; λ₂ = a + r * L; F₂ = optfunc(λ₂)
		end

		# iterations count
		i += 1

		if L < eps
			λ = (b + a) / 2
			minimum = optfunc(λ)
			break
		end
	end

	println("Optimization Results")
	println("-----------------------------------")
	println("-----------------------------------")
	println("Algorithm: Golden Section")
	println("Minimum point: $λ")
	println("Minimum: $minimum")
	println("Iterations: $i")
	

	return Optim_res(λ,minimum,i)
end

optfunc(x) = x^2 + 4*x - 4
_GoldenSection_(optfunc, [-10,10], 1e-8)
# _GoldenSection_(x -> 2x^2 + 3x + 1, [-10,10], 1e-8)