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

def wi(xi, _d, kernel):
    def _wi(x):
        return W(p(x, xi) / _d, kernel)
    return _wi
# %%
def Wi(xi, xs, q, kernel):
    _wi = wi(xi, d(xi, xs, q), kernel)
    A = [_wi(x) for x in xs]
    return np.diag(A)

def T(xs, d):
    polynomial = sk.PolynomialFeatures(d)
    return polynomial.fit_transform(xs)

def beta(W, A, b):
    return np.linalg.solve(A.T @ W @ A, A.T @ W @ b)

def fit(xs, xis, yis, f, d, kernel = 'tricube'): 
    q  = round(f * len(xis))
    B  = np.array([beta(Wi(xs[i], xis, q, kernel), T(xis, d), yis) for i in range(len(xs))])
    ys = [B[i] @ T(xs, d)[i] for i in range(len(xs))]
    return ys

# %%
print("FIGURA 6")
data = pd.read_csv(f'../data/dataset_multi.csv')
data['ozone'] = np.cbrt(data['ozone'])
rs = [50, 170, 290]
ts = list(range(60, 95, 1))
ws = [5, 10, 15]

xis = data[['radiation', 'temperature', 'wind']].to_numpy()
xis = (xis - np.mean(xis, axis = 0)) / np.std(xis, axis = 0)

fig, axes = plt.subplots(3, 3, figsize=(7, 7))
for i, j in [(i, j) for i in range(3) for j in range(3)]:
    xs = pd.DataFrame([[rs[i], t, ws[j]] for t in ts])
    xs.columns = ['radiation', 'temperature', 'wind']
    for col in xs:
        xs[col] = (xs[col] - np.mean(data[col])) / np.std(data[col])
    ys = fit(xs.to_numpy(),xis, data['ozone'], 0.8, 2)
    sns.lineplot(x=ts, y=ys, ax=axes[i][j], color='k')
    axes[i][j].set(ylim=(0, 7.5),
        xticks=[60, 70, 80, 90],
        yticks=[1, 4, 7])
fig.subplots_adjust(wspace=0.1, hspace=0.1)

axes[0][2].text(110, 3.75, '290', ha = 'right', va = 'center')
axes[1][2].text(110, 3.75, '170', ha = 'right', va = 'center')
axes[2][2].text(110, 3.75, '50', ha = 'right', va = 'center')

fig.text(0.50, 1.00, 'Wind Speed', ha = 'center', va = 'center')
fig.text(1.05, 0.50, 'Solar Radiation', ha = 'center', va = 'center', rotation = 'vertical')
fig.text(0.50, 0.05, 'Temperature', size = 20, ha = 'center', va = 'center')
fig.text(0.05, 0.50, 'Cube Root Ozone', ha = 'center', va = 'center', rotation = 'vertical')

axes[0][0].text(77, 9.5, '5', ha = 'center', va = 'center')
axes[0][1].text(77, 9.5, '10', ha = 'center', va = 'center')
axes[0][2].text(77, 9.5, '15', ha = 'center', va = 'center')


axes[0][1].set(yticks=[])
axes[1][0].set(xticks=[])
axes[1][1].set(xticks=[], yticks=[])
axes[1][2].set(xticks=[])
axes[2][1].set(yticks=[])

axes[0][0].xaxis.tick_top()
axes[0][1].xaxis.tick_top()
axes[0][2].xaxis.tick_top()
axes[0][2].yaxis.tick_right()
axes[1][2].yaxis.tick_right()
axes[2][2].yaxis.tick_right()

axes[0][0].set(xticklabels=[])
axes[0][1].set(xticklabels=[])
axes[0][2].set(xticklabels=[])
axes[0][2].set(yticklabels=[])
axes[1][2].set(yticklabels=[])
axes[2][2].set(yticklabels=[])

## Set common labels
#fig.text(0.06,0.5, 'Cube Root Ozone', ha = 'center', va = 'center')
#fig.text(0.5,0.06, 'Solar Radiation', ha = 'center', va = 'center')

##ys = fit(xs.to_numpy(), ss, cbrt_ozone, 0.8, 2)
#ax.set(ylim=(0, 7), aspect=(320/7))
# %% FIG 7
print("FIGURA 7")
l = 320
x = range(0, l+1, 25)
data = pd.read_csv(f'../data/dataset_multi.csv')
data['ozone'] = np.cbrt(data['ozone'])
D = {}
for var in ['radiation','temperature','wind']:
    D[var] = (data[var].mean(), data[var].std())
    data[var] = (data[var] - data[var].mean())/ data[var].std() ## Estandarizamos los datos
fig, axes = plt.subplots(3, 3, figsize=(5.5,5.5))
temperaturas = [90,75,62]
wind_speed = [5,10,15]
for i in range(0,3):
    for j in range(0,3):
        xs = pd.DataFrame({'radiation': range(l+1), 'temperature': temperaturas[i], 'wind': wind_speed[j]}) 
        for var in ['radiation', 'temperature', 'wind']:
            xs[var]  = (xs[var] - D[var][0]) / D[var][1]
        ys = fit(xs.to_numpy(), data[['radiation', 'temperature', 'wind']].to_numpy(), data['ozone'], 0.8, 2)
        sns.lineplot(x = range(l+1), y = ys, ax = axes[i][j], color = 'k')
        axes[i][j].set(yticks=[1,4,7],ylim = (0,7.25) ,xticks = [0,100,200,300],xlim = (0,340), aspect=(l/7))

fig.text(0.06,0.5, 'Cube Root Ozone', ha = 'center', va = 'center', rotation = 'vertical')
fig.text(0.5,0.06, 'Solar Radiation', ha = 'center', va = 'center')
fig.text(0.5,0.94, 'Wind Speed', ha = 'center', va = 'center')
for i in range(0,3):
    fig.text(0.24 + i * 0.275 ,0.90, wind_speed[i], ha = 'center', va = 'center')
    fig.text(0.94 ,0.24 + i * 0.265, temperaturas[2-i], ha = 'center', va = 'center')
fig.text(1,0.5, 'Temperature', ha = 'center', va = 'center', rotation = 'vertical')

# %%
# %% FIG 8
print("FIGURA 8")
l = 20
data = pd.read_csv(f'../data/dataset_multi.csv')
data['ozone'] = np.cbrt(data['ozone'])
D = {}
for var in ['radiation','temperature','wind']:
    D[var] = (data[var].mean(), data[var].std())
    data[var] = (data[var] - data[var].mean())/ data[var].std() ## Estandarizamos los datos
fig, axes = plt.subplots(3, 3, figsize=(5.5,5.5))
temperaturas = [62,76,90]
solar_radiation = [50,170,290]
for i in range(0,3):
    for j in range(0,3):
        xs = pd.DataFrame({'radiation': solar_radiation[j], 'temperature': temperaturas[i], 'wind': range(l+1)}) 
        for var in ['radiation', 'temperature', 'wind']:
            xs[var]  = (xs[var] - D[var][0]) / D[var][1]
        ys = fit(xs.to_numpy(), data[['radiation', 'temperature', 'wind']].to_numpy(), data['ozone'], 0.8, 2)
        sns.lineplot(x = range(l+1), y = ys, ax = axes[i][j], color = 'k')
        axes[i][j].set(yticks=[1,4,7],ylim = (0,7.25) ,xticks = [4,8,12,16],xlim = (0,20))
        
# %%