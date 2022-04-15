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


