function [argmin, minimum, iter] = interpolation(func, lam0, h, eps, H)
% BSD 3-Clause License
% Copyright (c) 2022, Langyan
% All rights reserved.
% function to implement Powell's Quadratic Interpolation optimization algorithm
% Input:
%       optfunc: function_handle
%               function to be optimized
%       lam0:
%               starting point
%       h:    
%               step size
%       eps:    
%               threshold to end the optim routine
%       H:    
%               maximum step size
% Output:
%       argmin:
%               optimized point (minimizer)
%       min:
%               optimized value (minimum)
%       iter:
%               iterations count
% Example:
%       >> [~] = interpolation(@(x) 3*x^2 + 150*x - 5, 0, 0.01, 1e-4, 2)
%       Optimization Results
%       -----------------------------------
%       -----------------------------------
%       Algorithm: Powell's Quadratic Interpolation
%       Minimum point: -25.00
%       Minimum: -1880.00
%       Iterations: 14

if ~isa(func,'function_handle')
    error('func must be a function handle')
end

lam1 = lam0 + h;
F0 = func(lam0); F1 = func(lam1);
if F0 < F1
    lam2 = lam0 - h;
else
    lam2 = lam0 + 2*h;
end

lam = [lam0,lam1,lam2];

iter = 0;

while true
    iter = iter+1;

    lam_m = (lam(1) + lam(2)) / 2 - divided_diff(func,lam(1:2)) / (2*divided_diff(func,lam));

    if func(lam_m) < func(lam(1))
        mincheck = true;
    else
        mincheck = false;
    end
    
    [~,index] = min(lam - lam_m);
    lam_n = lam(index);

    if mincheck
        if abs(lam_m - lam_n) > H
            [~,discard] = max(lam - lam_m);
            [~,replace] = min([func(lam(1)),func(lam(2)),func(lam(3))]);
            lam(discard) = lam(replace) + H * sign(func(lam(replace)) - func(lam(replace)+1e-3));
        elseif abs(lam_m - lam_n) < eps
            lam_star = [lam_n,lam_m];
            F = [func(lam_n),func(lam_m)];
            
            [minimum,minindex] = min(F);
            argmin = lam_star(minindex);

            fprintf("Optimization Results\n")
            fprintf("-----------------------------------\n")
            fprintf("-----------------------------------\n")
            fprintf("Algorithm: Powell's Quadratic Interpolation\n")
            fprintf("Minimum point: %4.2f\n",argmin)
            fprintf("Minimum: %4.2f\n", minimum)
            fprintf("Iterations: %d\n",iter)
            break
        else
            [~,discard] = max(lam - lam_m);
            lam(discard) = lam_m;
        end
    else
        [~,discard] = min(lam - lam_m);
        [~,replace] = min([func(lam(1)),func(lam(2)),func(lam(3))]);
        lam(discard) = lam(replace) + H * sign(func(lam(replace)) - func(lam(replace)+1e-3));
    end

end

end

function diff = divided_diff(func,x)
    if ~isa(func,'function_handle')
        error('func must be a function handle')
    end
    if length(x) == 1
        diff = func(x);
    else
        diff = (divided_diff(func,x(2:end)) - divided_diff(func,x(1:end-1))) / (x(end) - x(1));
    end
end













