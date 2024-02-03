# %%
import pandas as pd
import numpy as np
import sklearn as sk
import matplotlib.pyplot as plt
import seaborn as sns
from lib import train
# %%
data = pd.read_csv('../data/train.csv')
#%%
max_n = 30001
k = 5
K = 3

metric_data = pd.DataFrame(data = {'K': [], 'alpha': [], 'k': [], 'accuracy': [], 'precision': [], 'recall': []})
for n in [2**i for i in range(7,15)]:
    print(n)
    for alpha in [13, 0]:
        metric_data = pd.concat([metric_data, train.train(data=data, n=n, K=K, alpha=alpha, k=k)], ignore_index=True)
metric_data.to_csv(f'output/{n}_pca_on_off.csv')
# %% read file
n = 16384
pca_data = pd.read_csv(f'output/{n}_pca_on_off.csv')
# %% graph lineplots and save figure
sns.set_theme()
pca_data.loc[pca_data['alpha'] == 0.0, 'color'] = 0
pca_data.loc[pca_data['alpha'] != 0.0, 'color'] = 1
pca_data['time'] = (pca_data['time_pca'] + pca_data['time_knn'])/1e9
pca_data.loc[pca_data['alpha'] != 0.0, 'color'] = 1
ax = sns.lineplot(data=pca_data, x="n", y="time",
             hue="color", style="color")
ax.set(ylabel = "Tiempo de ejecución (s)")
legend_labels, _= ax.get_legend_handles_labels()
ax.legend(legend_labels, ['sin','con'], 
          title='PCA')

plt.savefig('output/pca_on_off.pdf', bbox_inches='tight')
# %%