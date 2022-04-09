function [argmin, min, iter] = goldsec(optfunc, interval, eps)
% function to implement Golden Section optimization algorithm
% Input:
%       optfun: function_handle
%               function to be optimized
%       interval:
%               initialize the interval to apply optim routine
%       eps:    
%               threshold to the optim routine
% Output:
%       argmin:
%               optimized point (minimizer)
%       min:
%               optimized value (minimum)
%       iter:
%               iterations count
% Example:
%       >> [~] = goldsec(@(x) x^2 + 4*x - 4, [-10,10], 1e-4)
%       Optimization Results
%       -----------------------------------
%       -----------------------------------
%       Algorithm: Golden Section
%       Minimum point: -2.00
%       Minimum: -8.00
%       Iterations: 26

if ~isa(optfunc,'function_handle')
    error('optfunc must be a function handle')
end

r = (sqrt(5) - 1) / 2;
% containers
a = interval(1);
b = interval(2);
L = b - a;
i = 0;
lam1 = a + r^2 * L;
lam2 = a + r * L;
F1 = optfunc(lam1);
F2 = optfunc(lam2);

% update container
while true
    if F1 < F2
        b = lam2; lam2 = lam1; F2 = F1;
        L = r * L; lam1 = a + r^2 * L; F1 = optfunc(lam1);
    else
        a = lam1; lam1 = lam2; F1 = F2;
        L = r * L; lam2 = a + r * L  ; F2 = optfunc(lam2);
    end

    i = i+1;

    if L < eps
        argmin = (b + a)/2;
        min = optfunc(argmin);
        iter = i;
        break
    end
end

fprintf("Optimization Results\n")
fprintf("-----------------------------------\n")
fprintf("-----------------------------------\n")
fprintf("Algorithm: Golden Section\n")
fprintf("Minimum point: %4.2f\n",argmin)
fprintf("Minimum: %4.2f\n", min)
fprintf("Iterations: %d\n",iter)
end