Mathematical Optimization
---

*Mathematical Optimization Algorithms implemented in various languages (including Python, Julia, Matlab, R)*

- [Mathematical Optimization](#mathematical-optimization)
- [Overview](#overview)
- [Examples](#examples)
  - [Golden Section](#golden-section)
    - [Python](#python)
    - [Julia](#julia)
    - [Matlab](#matlab)
    - [R](#r)
  - [Powell's Quadratic Interpolation](#powells-quadratic-interpolation)
    - [Python](#python-1)
    - [Julia](#julia-1)
    - [Matlab](#matlab-1)
    - [R](#r-1)

## Overview
- **Univariate Optimize**
  - [Golden Section](#golden-section)
  - [Powell's Quadratic Interpolation](#powells-quadratic-interpolation)
- **Multivariate Optimize**
  - To be added

## Examples

### Golden Section

#### Python
```python
>>> import goldsec
>>> f = lambda x: x**2 + 4 * x - 4
>>> fConfig = goldsec.GoldSec(f, [-10,10], eps=1e-8)
>>> result = fConfig.GoldSection()
Optimization Results
-----------------------------------
-----------------------------------
Algorithm: Golden Section
Minimum point: -1.9999999770027157
Minimum: -8.0
Iterations: 45
>>> result
<util.utilities.Optim_res object at ...>
>>> result.argmin
-1.9999999770027157
>>> result.min
-8.0
>>> result.iter
45
```

#### Julia
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

#### Matlab
```matlab
>> [~] = goldsec(@(x) x^2 + 4*x - 4, [-10,10], 1e-4)
Optimization Results
-----------------------------------
-----------------------------------
Algorithm: Golden Section
Minimum point: -2.00
Minimum: -8.00
Iterations: 26
```

#### R
```r
> goldsec(function(x) x^2 + 4*x - 4, c(-10,10))
```

### Powell's Quadratic Interpolation

#### Python
```python
>>> from interpolation import *
>>> f = lambda x: x**2 + 100 * x - 4
>>> fConfig = Interpolation(f,lam0 = 0, h = 0.01, H = 2)
>>> result = fConfig.powells()
Optimization Results
-----------------------------------
-----------------------------------
Algorithm: Powell's Quadratic Interpolation
Minimum point: -49.999999999999915
Minimum: -2504.0000000000005
Iterations: 26
>>> result
<util.utilities.Optim_res object at ...>
>>> result.argmin
-49.999999999999915
>>> result.min
-2504.0000000000005
>>> result.iter
26
```

#### Julia
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

#### Matlab
```matlab
>> [argmin,minimum,iter] = interpolation(@(x) 3*x^2 + 150*x - 5, 0, 0.01, 1e-4, 2)
Optimization Results
-----------------------------------
-----------------------------------
Algorithm: Powell's Quadratic Interpolation
Minimum point: -25.00
Minimum: -1880.00
Iterations: 14

argmin =

  -25.0000

minimum =

       -1880

iter =

    14
```

#### R
```r
> powells(function(x) x^2 + 4*x - 4)
```