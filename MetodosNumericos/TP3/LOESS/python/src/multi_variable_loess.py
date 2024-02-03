# %%
import numpy as np
import pandas as pd
import sklearn.preprocessing as sk
import matplotlib.pyplot as plt
import seaborn as sns
import scipy.stats as sps

from kernels import W
from single_variable_loess import fit as single_variable_fit
# %%
def p(x, y):
    return np.linalg.norm(x-y)

def d(xi, xs, q):
    return np.sort([p(xi, x) for x in xs])[q]

def wi(xi, _d, kernel): ##devuelve una funcion centrada en xi
    def _wi(x):
        return W(p(x, xi) / _d, kernel)
    return _wi
# %%
def Wi(xi, xs, q, kernel):
    _wi = wi(xi, d(xi, xs, q), kernel)                                                       ##funcion centrada en wi
    A = [_wi(x) for x in xs]                                                                 ## A es una lista de pesos para todas las muestras
    return np.diag(A)                                                                        ## diagonalizo A

def T(xs, d):
    polynomial = sk.PolynomialFeatures(d)                                                    ## d == lineal o cuad
    return polynomial.fit_transform(xs)                                                      ## devuelclo la matriz de muestras

def beta(W, A, b):
    return np.linalg.solve(A.T @ W @ A, A.T @ W @ b)                                         ## devuelvo los coefs de regresion

def fit(xs, xis, yis, f, d, kernel = 'tricube'):                                             ## los que quiero predecir, los x del dataset, los y, f, linear o no, kernel
    q  = round(f * len(xis))
    B  = np.array([beta(Wi(xs[i], xis, q, kernel), T(xis, d), yis) for i in range(len(xs))])
    ys = [B[i] @ T(xs, d)[i] for i in range(len(xs))]
    return ys

# %%
