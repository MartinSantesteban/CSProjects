# %%
import numpy as np
import pandas as pd
import scipy.stats as sps
import seaborn as sns
import matplotlib.pyplot as plt
from multi_variable_loess import fit, single_variable_fit
# %% Figure 4 - Cleveland 1988
#TODO twin ticks
fig, axes = plt.subplots(2, figsize=(5,10))
data = pd.read_csv(f'../data/dataset_multi.csv')
xs = data[['radiation', 'temperature', 'wind']].to_numpy()
data['ys'] = fit(xs, xs, data['ozone'], 0.4, 1)
residues = data['ozone'] - data['ys']
sns.scatterplot(
    x = sps.norm.ppf(np.linspace(0.01, 0.99, len(residues))),
    y = np.sort(residues),
    s = 15, facecolor = 'None', linewidth = 1, edgecolor = 'k',
    ax=axes[0])
sns.scatterplot(data = data,
    x = 'ys',
    y = np.abs(residues),
    s = 15, facecolor = 'None', linewidth = 1, edgecolor = 'k',
    ax=axes[1])
sns.lineplot(data = data,
   x = 'ys',
   y = single_variable_fit(data['ys'], np.abs(residues), 2/3, 1),
   color='k',
   ax=axes[1])
axes[0].set(xlabel='Normal Quantiles', ylabel='Residuals', yticks=[-50, -25, 0, 25, 50, 75], xlim=(-3,3), ylim=(-50, None))
axes[0].set_aspect(6 / np.ptp(residues))
axes[1].set(xlabel='Fitted Values',
    ylabel='Absolute Residuals', xticks=[0, 25, 50, 75, 100, 125],
    yticks=[0, 25, 50, 75])
axes[1].set_aspect(np.ptp(data['ys']) / np.ptp(np.abs(residues)))
plt.savefig('../figures/figure_4_1988.pdf',format = 'pdf', bbox_inches='tight')
# %%
data = pd.read_csv(f'../data/dataset_multi.csv')
xs = data[['radiation', 'temperature', 'wind']].to_numpy()
data['ys'] = fit(xs, xs, data['ozone'], 0.4, 1)
residues = data['ozone'] - data['ys']
fig = sns.scatterplot(
    x = sps.norm.ppf(np.linspace(0.01, 0.99, len(residues))),
    y = np.sort(residues),
    s = 15, facecolor = 'None', linewidth = 1, edgecolor = 'k')
fig.set(xlabel='Normal Quantiles', ylabel='Residuals', yticks=[-50, -25, 0, 25, 50, 75], xlim=(-3,3), ylim=(-50, None))
fig.set_aspect(6 / np.ptp(residues))
plt.savefig('../figures/figure_4_1988_single01.pdf',format = 'pdf', bbox_inches='tight')
# %%
data = pd.read_csv(f'../data/dataset_multi.csv')
xs = data[['radiation', 'temperature', 'wind']].to_numpy()
data['ys'] = fit(xs, xs, data['ozone'], 0.4, 1)
residues = data['ozone'] - data['ys']
fig = sns.scatterplot(data = data,
    x = 'ys',
    y = np.abs(residues),
    s = 15, facecolor = 'None', linewidth = 1, edgecolor = 'k')
sns.lineplot(data = data,
   x = 'ys',
   y = single_variable_fit(data['ys'], np.abs(residues), 2/3, 1),
   color='k')
fig.set(xlabel='Fitted Values',
    ylabel='Absolute Residuals', xticks=[0, 25, 50, 75, 100, 125],
    yticks=[0, 25, 50, 75])
fig.set_aspect(np.ptp(data['ys']) / np.ptp(np.abs(residues)))
plt.savefig('../figures/figure_4_1988_single02.pdf',format = 'pdf', bbox_inches='tight')
# %%
