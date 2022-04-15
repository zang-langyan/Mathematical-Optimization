# BSD 3-Clause License
# Copyright (c) 2022, Langyan
# All rights reserved.

""" # Optimization Result struct
    Optim_res(argmin,min,iter) -> Optim_res
* `argmin::Real` - the optimized minimizer
* `min::Real` - the optimized minimum
* `iter::Int` - total iterations
"""
struct Optim_res
	argmin :: Real
	min :: Real
	iter :: Int
end

""" utility function to compute divided difference [y₀,y₁,y₂,⋅⋅⋅] 
    divided_diff(func::Function,x::AbstractVector) -> Real

* `func::Function` - function divided diff applied to
* `x::AbstractVector` - points to compute divided diff
"""
function divided_diff(func::Function,x::AbstractVector)
    if length(x) == 1
        return func(x[1])
    else
        return (divided_diff(func, x[2:end]) - divided_diff(func, x[1:end-1])) / (x[end] - x[1])
    end
end