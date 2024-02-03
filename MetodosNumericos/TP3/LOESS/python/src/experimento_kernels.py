# %%
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from multi_variable_loess import fit, single_variable_fit

# %%
def synthetic_data(xs, g, seed=0):
    np.random.seed(seed)
    ys = [g(xi) for xi in xs]
    return pd.DataFrame({'x': xs, 'y': ys, 'ys': [y + np.random.normal(loc = 0.0, scale = 1.0, size = None) for y in ys]})

# %%
sns.set_theme()
n = 128
xs = np.linspace(0, 2*np.pi, n)
fs = [(np.sin, r'$sin(x)$', 0),
      (lambda x : (-0.125*(x**3) + 0.5*(x**2) + x)/5, r'$\frac{-\frac{1}{8}(x^3) + \frac{1}{2}x^2 + x}{5}$', 1)
     ]

fig, ax = plt.subplots(2, 1, figsize = (15, 10))
for (g, name, i) in fs:
    data = synthetic_data(xs, g, 512)

    f = 0.5
    d = 1

    sns.lineplot(data = data, x = 'x', y = data['y'], color = 'k', label = name, ax = ax[i])
    sns.scatterplot(data = data, x = 'x', y = data['ys'], ax = ax[i])
    kernels = pd.DataFrame({})
    for k in ['uniform', 'triangle', 'bicuadratic', 'tricube', 'epanechnikov']:
        fitted = pd.DataFrame({'x': data['x'], 'y': single_variable_fit(data['x'], data['ys'], f, d, kernel=k), 'k': k})
        kernels = pd.concat([kernels, fitted], ignore_index=True)
    sns.lineplot(data = kernels, x = 'x', y = 'y', ax = ax[i], hue='k', style='k')
    ax[i].legend(title='kernel')
    ax[i].set(xlabel = r"$x$", ylabel = r"$f(x)$")
    ax[i].set(ylim=(-1.1, 1.1))
#ax[1].legend([],[], frameon=False)
h, l = ax[1].get_legend_handles_labels()
plt.legend(h[:1],l[:1], bbox_to_anchor=(0.1375, 0.175))
plt.savefig(f"../figures/kernels.pdf", bbox_inches = 'tight')
# %%
