# Steklov problem on hypersurfaces of revolution: numerical experiments

We are interested in the Steklov problem on hypersurfaces of revolution in the Euclidean space. 
While investigating it, we discovered a strange phenomenon. 
Some eigenvalues have a finite critical length associated with them, while others have got an infinite critical length.

We were able to prove that infinitely many eigenvalues have a finite critical length, 
however we were **not** able to quantified how many eigenvalues have an infinite critical length associated with them.


There exists an algorithm, called "extension process", which gives the sharp upper bound $B_n^k(L)$ for the $k$ th eigenvalue, 
given the meridian length $L$ of the hypersurface and its dimension $n$. We used this algorithm to create different programs,
which allows us to check what happen to "big" eigenvalues. We were able to check roughly to the $190' 000$ th eigenvalue.

These programs support the following conjecture:

**Conjecture**. Given $n \ge 3$, there exist $K \in \mathbb{N}$ such that for each $k \ge K$, the $k$ th eigenvalue has a finite critical length associated with.

**Remark**. It is now known that the conjecture is true in dimension $n=2, 3, 4$, but it is still to be proved or refuted in dimension $n \ge 5$.

## Programs

Find the programs in the folder "src". Here an overview of how they work.

### sharp_upper_bound.jl
* Inputs:
  * the dimension $n \ge 3$, 
  * the eigenvalue $k \ge 1$,
  * the meridian length $L \in (0, \infty)$.
* Output: 
  * the sharp upper bound $B_n^k(L)$.

### plot_sharp_upper_bound.jl
* Inputs: 
  * the dimension $n \ge 3$,
  * the eigenvalue $k \ge 1$.
* Outputs: 
  * a plot of the function $L \longmapsto B_n^k(L)$, 
  * the sharp upper bound $B_n^k := \sup_{L \in (0, \infty)} \{ B_n^k(L)\}$,
  * the critical length $L_k \in (0, \infty]$.


### plot_each_sd_sn.jl
* Inputs: 
  * the dimension $n \ge 3$,
  * the eigenvalue $k \ge 1$.
* Outputs: 
  * a plot of the function $L \longmapsto B_n^k(L)$, 
  * the sharp upper bound $B_n^k := \sup_{L \in (0, \infty)} \{ B_n^k(L)\}$, 
  * the critical length $L_k \in (0, \infty]$,
  * the mixed Steklov-Dirichlet and Steklov-Neumann eigenvalues.

### critical_length.jl
* Inputs: 
  * the dimension $n \ge 3$,
  * the eigenvalue $k \ge 1$.
* Output: 
  * the biggest $\tilde{k} \in \\{1, 2, \ldots, k\\}$ 
  such that $\tilde{k}$ has an infinite critical length.
  
### diagnosis_eigenvalue.jl
* Inputs: 
  * the dimension $n \ge 3$,
  * the diagnosis eigenvalue $k \ge 1$.
* Output: 
  * the  biggest diagnosis eigenvalue which has an infinite critical length.
  
**Remark:** critical_length.py gives more information (check all eigenvalues, not only the diagnosis ones) than diagnosis_eigenvalue.py, but the latter can check way further in a reasonnable time.
