class Optim_res:
	"""Optimization Result class

	Used to return optimization results object

	Return an Optim_res object

	Parameters
	----------
	argmin : float
		the optimized minimizer
	min : float
		the optimized minimum
	iter : float
		total iterations
	"""
	def __init__(self, argmin, min, iter) -> None:
		self.argmin = argmin
		self.min = min
		self.iter = iter

def divided_diff(func,x):
    """utility function to compute divided difference [y₀,y₁,y₂,⋅⋅⋅]
    """
    if len(x) == 1:
        return func(x[0])
    else:
        return (divided_diff(func, x[1:]) - divided_diff(func, x[:-1])) / (x[-1] - x[0])

sign = lambda x: (1, -1)[x<0]