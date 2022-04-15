include("../util/utilities.jl")

""" # Powell's Quadratic Interpolation Algorithm
    _powells_(func::Function, λ0::Real = 0, h::Real = 0.01, ε::Real = 1e-4, H::Real = 2) -> Optim_res

Optimize a function using Powell's Quadratic Interpolation Algorithm

# Parameters
## arguments
* `func::Function` - function to be optimized

## keyword arguments
* `λ0::Real` - starting point (default 0)
* `h::Real` - step size (default 0.01)
* `ε::Real` - threshold to end the optimization (prescrided accuracy) (default 1e-4)
* `H::Real` - maximum step size (default 2)

# Examples
```julia
julia> optfunc(x) = x^2 + 100 * x - 4;

julia> _powells_(optfunc)
Optimization Results
-----------------------------------
-----------------------------------
Algorithm: Powell's Quadratic Interpolation
Minimum point: -49.999999999999915
Minimum: -2504.0000000000005
Iterations: 26
Optim_res(-49.999999999999915, -2504.0000000000005, 26)

julia> _powells_(x -> 2x^2 + 3x + 1)
Optimization Results
-----------------------------------
-----------------------------------
Algorithm: Powell's Quadratic Interpolation
Minimum point: -0.7499999999999996
Minimum: -0.125
Iterations: 2
Optim_res(-0.7499999999999996, -0.125, 2)

```
"""
function _powells_(func::Function, λ0::Real = 0, h::Real = 0.01, ε::Real = 1e-4, H::Real = 2)
    λ1 = λ0 + h
    F0 = func(λ0); F1 = func(λ1)
    (F0 < F1 ? λ2 = λ0 - h : λ2 = λ0 + 2*h)
    λ = [λ0,λ1,λ2]

    i = 0

    while true
        i += 1

        λm = (λ[1] + λ[2]) / 2 - divided_diff(func,[λ[1],λ[2]]) / (2 * divided_diff(func,[λ[1],λ[2],λ[3]]))

        (func(λm) < func(λ[1]) ? minimumcheck = true : minimumcheck = false)

        λn = λ[argmin([abs(x - λm) for x in λ])]
        if minimumcheck
            if abs(λm - λn) > H
                λ[argmax([abs(x - λm) for x in λ])] = λ[argmin([func(x) for x in λ])] + H * sign(func(λ[argmin([func(x) for x in λ])]) - func(λ[argmin([func(x) for x in λ])] + 1e-3))
            elseif abs(λm - λn) < ε
                λstar = [λn,λm]
                F  = [func(λn),func(λm)]

                argMinimum = λstar[argmin(F)]
                Minimum = minimum(F)
                println("Optimization Results")
                println("-----------------------------------")
                println("-----------------------------------")
                println("Algorithm: Powell's Quadratic Interpolation")
                println("Minimum point: $argMinimum")
                println("Minimum: $Minimum")
                println("Iterations: $i")

                return Optim_res(λstar[argmin(F)],minimum(F),i)
            else
                λ[argmax([func(x) for x in λ])] = λm
            end
        else # λm is maximum point
            λ[argmin([abs(x - λm) for x in λ])] = λ[argmin([func(x) for x in λ])] + H * sign(func(λ[argmin([func(x) for x in λ])]) - func(λ[argmin([func(x) for x in λ])] + 1e-3))
        end
    end

end

optfunc(x) = x^2 + 100*x - 4
_powells_(optfunc)