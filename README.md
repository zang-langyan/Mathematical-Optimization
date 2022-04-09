# Mathematical Optimization
 Mathematical Optimization Algorithms implemented in various languages (including Python, Julia, Matlab, R)

## Univariate function

### Golden Section Algorithm

Golden ratio $r$: $r^2 + r -1 = 0 \Rightarrow r = \dfrac{\sqrt{5} - 1}{2} = 0.618034$

**Basic golden section algorithm**:

> **_NOTE:_**  $L_0 = b - a$ and threshold $\varepsilon$, iteration count $i = 0$

1. Set $\lambda_1 = a + r^2L_0$ and $\lambda_2 = a + rL_0$
2. Compute $F(\lambda_1)$ and $F(\lambda_2)$, $i = i+1$
3. $$\begin{cases} 
F(\lambda_1) < F(\lambda_2) \Rightarrow b = \lambda_2, {\color{green}{\lambda_2 = \lambda_1}}, L_i = b-a, \lambda_1 =  a + r^2L_i \\ 
F(\lambda_1) > F(\lambda_2) \Rightarrow a = \lambda_1, {\color{green}{\lambda_1 = \lambda_2}}, L_i = b-a, \lambda_2 =  a + rL_i
\end{cases}$$
4. If $L_i < \varepsilon \Rightarrow \lambda^* = \dfrac{b+a}{2}$, otherwise repeat Step 2-4

> **_Reason:_** $\color{green}{\dfrac{r^2L_0}{rL_0} = r}$

### Powell's Interpolation Algorithm

To be added