# %%
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from single_variable_loess import fit
# %% Figure B (non robust) - Cleveland 1979
data = pd.read_csv(f'../data/dataset_single.csv')
ys = fit(data['x'], data['y'], 0.5, 1)
data['fit'] = ys

ax = sns.scatterplot(data = data, x = 'x', y = 'y', color = 'k')
ax = sns.lineplot(data = data, x = 'x', y = 'fit', color = 'k')
ax.set_aspect(10)
# %% Figure C (non robust) - Cleveland 1979
data = pd.read_csv(f'../data/dataset_single.csv')
ys = fit(data['x'], data['y'], 0.2, 1)
data['fit'] = ys

ax = sns.scatterplot(data = data, x = 'x', y = 'y', color = 'k')
ax = sns.lineplot(data = data, x = 'x', y = 'fit', color = 'k')
ax.set_aspect(10)

plt.savefig('../figures/figure_B&C_1979.pdf',format = 'pdf')
# %%
