from math import sqrt

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

class GoldSec:
	"""Golden Section Algorithm class

    Used to instantiate GS algorithm instances

    Return a GoldSec object

    Parameters
    ----------
    optfunc : function
        self-defined function
    interval : float
        the interval to apply GS algorithm
    eps : float
        threshold to end the optimization (prescrided accuracy) (default 1e-4)
    """
	def __init__(self, optfunc, interval, eps = 1e-4):
		self.optfunc = optfunc
		self.interval = interval
		self.eps = eps

	def GoldSection(self, **kwarg):
		"""
        function applying Golden Section Algorithm to `GoldSec` objects

        Parameters
        ----------
		keywork arguments (optional)
        opfunc : function, (update)
            self-defined function
        interval : float, (update)
            the interval to apply GS algorithm
        eps : float, (update)
            threshold to end the optimization (prescrided accuracy) (update)

        Examples
        --------
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
		<goldsec.Optim_res object at ...>
		>>> result.argmin
		-1.9999999770027157
		>>> result.min
		-8.0
		>>> result.iter
		45
        """
		for kw, value in kwarg.items():
			if kw == 'optfunc':
				self.optfunc = value
			elif kw == 'interval':
				self.interval = value
			elif kw == 'eps':
				self.eps = value
			else:
				raise Exception(f'keyword argument "{kw}" not supported')

		# check if dfunc callable
		if not callable(self.optfunc):
			raise Exception('"optfunc" must be a function. Recreate the object with a valid density function')
		
		# learning rate
		r = (sqrt(5) - 1) / 2
		
		# containers
		a, b = self.interval[0], self.interval[1]
		L = b - a
		i = 0
		lam1, lam2 = a + r**2 * L, a + r * L
		F1, F2 = self.optfunc(lam1), self.optfunc(lam2)

		
		# update containers
		while True:
			if F1 < F2:
				b = lam2
				lam2 = lam1
				F2 = F1
				L = r * L
				lam1 = a + r**2 * L
				F1 = self.optfunc(lam1)
			else:
				a = lam1
				lam1 = lam2
				F1 = F2
				L = r * L
				lam2 = a + r * L
				F2 = self.optfunc(lam2)

			i += 1

			if L < self.eps:
				lam = (b + a) / 2
				F = self.optfunc(lam)
				break

		print('Optimization Results')
		print('-----------------------------------')
		print('-----------------------------------')
		print('Algorithm: Golden Section')
		print(f'Minimum point: {lam}')
		print(f'Minimum: {F}')
		print(f'Iterations: {i}')

		return Optim_res(lam,F,i)

def main():
	f = lambda x: x**2 + 4*x - 4
	fConfig = GoldSec(f, [-10,10], eps=1e-8)
	fConfig.GoldSection()
	# GoldSec.GoldSection(fConfig)

if __name__ == "__main__":
	main()