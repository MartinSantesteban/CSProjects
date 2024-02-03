# %% import modules
import numpy as np
import pandas as pd
from lib import train
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle
import seaborn as sns

# %% import dataset
data = pd.read_csv('../data/train.csv')

# %% run for values
n = 5000
K = 5
alpha_values = list(range(1,10)) + list(range(10,20,5)) + list(range(20, 50, 10)) + [50, 75, 100, 150, 200]
k_values     = list(range(1,10)) + list(range(10,20,5)) + list(range(20, 50, 10)) + [50, 75, 100, 150, 200]

metric_data = pd.DataFrame(data = {'n': [], 'K': [], 'alpha': [], 'k': [], 'accuracy': [], 'precision': [], 'recall': []})

for alpha in alpha_values:
    metric_data = pd.concat([metric_data, train.train(data=data, n=n, K=K, alpha=alpha, k=k_values)], ignore_index=True)
metric_data.to_csv(f'output/{n}_alpha_k_heatmap.csv')
# %% save to file
metric_data.to_csv(f'output/{n}_alpha_k_heatmap.csv')

# %% build pivot table
metric_data = pd.read_csv(f'output/{n}_alpha_k_heatmap.csv')
heat_metrics = metric_data.drop(['n', 'K', 'precision', 'recall'], axis=1).groupby(['alpha', 'k'], as_index=False)
heat_data = heat_metrics.mean().pivot('alpha', 'k', 'accuracy')

# %% graph heatmap and save figure
sns.set_theme()
ax = sns.heatmap(heat_data, linewidths=.5, cmap="magma")
ax.set_aspect('equal')
labels = list(fib(13))[2:]
ax.set_xticklabels(labels)
ax.set_yticklabels(labels)
ax.set(xlabel=r'$k$', ylabel=r'$\alpha$')
#colocamos un label en el valor máximo
max = heat_data.to_numpy().max()
ax.add_patch(Rectangle((3,6),1,1, fill=False, edgecolor='black', lw=3))
ax.annotate('max', (3.5,6.5), color='black', weight='bold', 
            fontsize=6, ha='center', va='center')

plt.savefig('output/acc_alph_k.pdf', bbox_inches='tight')

