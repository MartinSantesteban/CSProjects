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
K = 10
alpha_values = [0, 20]
k_values = [i for i in range(1, 25)] + [i for i in range(25, 50, 5)] + [i for i in range(50, 100, 10)]

metric_data = pd.DataFrame(data = {'n': [], 'K': [], 'alpha': [], 'k': [], 'accuracy': [], 'precision': [], 'recall': []})

for alpha in alpha_values:
    metric_data = pd.concat([metric_data, train.train(data=data, n=n, K=K, alpha=alpha, k=k_values)], ignore_index=True)

# %% save to file
metric_data.to_csv(f'output/{n}_pca_on_off.csv')

# %% read file
pca_data = pd.read_csv(f'output/{n}_pca_on_off.csv')

# %% graph lineplots and save figure
sns.set_theme()
pca_data.loc[pca_data['alpha'] == 0.0, 'color'] = 0
pca_data.loc[pca_data['alpha'] != 0.0, 'color'] = 1
ax = sns.lineplot(data=pca_data, x="k", y="accuracy",
             hue="color", style="color")
legend_labels, _= ax.get_legend_handles_labels()
ax.legend(legend_labels, ['sin','con'], 
          title='PCA')

plt.savefig('output/pca_on_off.pdf', bbox_inches='tight')

# %%