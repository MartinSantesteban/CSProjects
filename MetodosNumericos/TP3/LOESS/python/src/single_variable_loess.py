# %%
from kernels import W
import numpy as np
import pandas as pd
import seaborn as sns
# %%
def p(x, y):
    return np.linalg.norm(x-y)

def hi(xi, xs, r):
    return np.sort([p(xi, s) for s in xs])[min(r, len(xs)-1)]

def wk(xk, _hi, kernel):
    def _wk(xi):
        return W(p(xi, xk) / _hi, kernel)
    return _wk
# %%
def Wi(xi, xs, r, kernel):
    A = [wk(xi, hi(xi, xs, r), kernel)(x) for x in xs]
    return np.diag(A)

def X(xs, d):
    A = np.empty(shape=(len(xs), d+1))
    for (i, j) in [(i, j) for i in range(A.shape[0]) for j in range(A.shape[1])]:
        A[i, j] = xs[i]**j
    return A
    
def beta(W,X,y):
    return np.linalg.solve(X.T @ W @ X, X.T @ W @ y)

def fit(xs : list, ys : list, f, d, kernel='tricube'): 
    r = round(f * len(xs))
    betas = [beta(Wi(xs[i], xs, r, kernel), X(xs, d), ys) for i in range(len(xs))]
    res = [sum([betas[i][j] * (xs[i]**j) for j in range(d+1)]) for i in range(len(xs))]
    return res