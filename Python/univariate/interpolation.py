# BSD 3-Clause License
# Copyright (c) 2022, Langyan
# All rights reserved.

from util.utilities import Optim_res, divided_diff, sign
import numpy as np

class Interpolation:
    """Powell's Quadratic Interpolation Algorithm class

	Used to instantiate Powell's algorithm instances

	Return a Interpolation object

	Parameters
	----------
	func : function
		self-defined function
	lam0 : float
		starting point
    h : float
        step size
	eps : float
		threshold to end the optimization (prescrided accuracy) (default 1e-4)
    H : float
        maximum step size
	"""
    def __init__(self, func, lam0, h, H, eps = 1e-4) -> None:
        self.func = func
        self.lam0 = lam0
        self.h = h
        self.eps = eps
        self.H = H

    def powells(self,**kwarg):
        """
        function applying Powell's Quadratic Interpolation Algorithm to `Interpolation` objects
        
        Parameters 
        ----------
        func : function
            self-defined function
        lam0 : float
            starting point
        h : float
            step size
        eps : float
            threshold to end the optimization (prescrided accuracy) (default 1e-4)
        H : float
            maximum step size
        
        Examples
        --------
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
		"""
        for kw, value in kwarg.items():
            if kw == 'func' or kw == 'optfunc':
                self.func = value
            elif kw == 'lam0':
                self.lam0 = value
            elif kw == 'h':
                self.h = value
            elif kw == 'eps':
                self.eps = value
            elif kw == 'H':
                self.H = value
            else:
                raise Exception(f'keyword argument "{kw}" not supported')
        
        # check if func callable
        if not callable(self.func):
            raise Exception('"func" must be a function. Recreate the object with a valid function')
        
        lam1 = self.lam0 + self.h
        F0, F1 = self.func(self.lam0), self.func(lam1)
        if F0 < F1:
            lam2 = self.lam0 - self.h
        else:
            lam2 = self.lam0 + 2 * self.h

        lam = [self.lam0, lam1, lam2]

        i = 0

        while True:
            i += 1

            lam_m = (lam[0] + lam[1]) / 2 - divided_diff(self.func, [lam[0], lam[1]]) / (2 * divided_diff(self.func, [lam[0], lam[1], lam[2]]))

            if self.func(lam_m) < self.func(lam[0]):
                mincheck = True
            else:
                mincheck = False

            lam_n = lam[np.argmin(np.array([abs(x - lam_m) for x in lam]))]

            if mincheck:
                if abs(lam_m - lam_n) > self.H:
                    lam[np.argmax(np.array([abs(x - lam_m) for x in lam]))] = lam[np.argmin(np.array([self.func(x) for x in lam]))] + self.H * sign(self.func(lam[np.argmin(np.array([self.func(x) for x in lam]))]) - self.func(lam[np.argmin(np.array([self.func(x) for x in lam]))] + 1e-3))
                elif abs(lam_m - lam_n) < self.eps:
                    lam_star = [lam_n,lam_m]
                    F = [self.func(lam_n),self.func(lam_m)]

                    argmin = lam_star[np.argmin(np.array(F))]
                    minimum = min(F)

                    print('Optimization Results')
                    print('-----------------------------------')
                    print('-----------------------------------')
                    print('Algorithm: Powell\'s Quadratic Interpolation')
                    print(f'Minimum point: {argmin}')
                    print(f'Minimum: {minimum}')
                    print(f'Iterations: {i}')

                    return Optim_res(argmin, minimum, i)
                else:
                    lam[np.argmax(np.array([self.func(x) for x in lam]))] = lam_m
            else:
                lam[np.argmin(np.array([abs(x - lam_m) for x in lam]))] = lam[np.argmin(np.array([self.func(x) for x in lam]))] + self.H * sign(self.func(lam[np.argmin(np.array([self.func(x) for x in lam]))]) - self.func(lam[np.argmin(np.array([self.func(x) for x in lam]))] + 1e-3))

def main():
    f = lambda x: x**2 + 100 * x - 4
    fConfig = Interpolation(f,lam0 = 0, h = 0.01, H = 2)
    fConfig.powells()

if __name__ == "__main__":
    main()
