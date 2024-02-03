# %% import modules
import numpy as np
import pandas as pd
from lib import train
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle
import seaborn as sns
from sklearn import preprocessing

# %% import dataset
data = pd.read_csv('../data/train.csv')

# %% run for values
max_n = 5000
n_values = range(200, max_n+1, 25)
K = 5
alpha = 20

metric_data = pd.DataFrame(data = {'K': [], 'alpha': [], 'k': [], 'accuracy': [], 'precision': [], 'recall': []})

for n in n_values:
    print(f'n:{n}', flush=True)
    max_k = n-(n//K)
    k_values = range(1, 101)
    metric_data = pd.concat([metric_data, train.train(data=data, n=n, K=K, alpha=alpha, k=k_values)], ignore_index=True)

# %% save to file
metric_data.to_csv(f'output/{n}_n_k.csv')

# %% build pivot table
metric_data = pd.read_csv(f'output/{n}_n_k.csv')
heat_metrics = metric_data.drop(['K', 'alpha', 'precision', 'recall'], axis=1).groupby(['k', 'n'], as_index=False)
heat_table = heat_metrics.mean().pivot('k', 'n', 'accuracy')

# %% graph heatmap and save figure
sns.set_theme()
normalized = heat_table.sub(heat_table.min(axis=0), axis=1)
normalized = normalized.div(normalized.max(axis=0), axis=1)
ax = sns.heatmap(normalized, cmap="magma")

yticks = np.array([1, 20, 40, 60, 80, 100]) - 1
ylabels = yticks + 1
xticks  = np.array([0, 32, 72, 112, 152, 192])
xlabels = [200, 1000, 2000, 3000, 4000, 5000]

ax.set_yticks(yticks+0.5)
ax.set_yticklabels(ylabels)
ax.set_xticks(xticks+0.5)
ax.set_xticklabels(xlabels)
ax.set(xlabel=r'$n$', ylabel=r'$k$')
ax.set_aspect('equal')

plt.savefig('output/n_k.pdf', bbox_inches='tight')

# %%