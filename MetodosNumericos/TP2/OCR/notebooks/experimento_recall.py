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
metric_data = pd.DataFrame(data = {'K': [], 'alpha': [], 'k': [], 'accuracy': [], 'precision': [], 'recall': []})
for rc in [0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6]:
    print('rc: ', rc, flush=True)
    metric_data = pd.concat([metric_data, train.train(data=data, n=20000, K=5, alpha=20, k=20, pr=0, rc=np.array([0, 0, 0, rc, 0, 0, 0, 0, 0, 0]))], ignore_index=True)
metric_data.to_csv(f'output/raw_recall.csv')
metric_data[['n', 'k', 'recall', 'recall_force']].to_csv(f'output/recall.csv')
# %% read file
recall_data = pd.read_csv(f'output/raw_recall.csv')
# %% graph lineplots and save figure
sns.set_theme()
graph_data = recall_data[['recall_force', 'precision', 'recall', 'accuracy']]
ax = sns.lineplot(data=recall_data, x="recall_force", y="precision", label='precision')
sns.lineplot(data=recall_data, x="recall_force", y="recall", label='3 recall', ax=ax)
sns.lineplot(data=recall_data, x="recall_force", y="accuracy", label='accuracy', ax=ax)
ax.set(xlabel = "3 recall force", ylabel='')
plt.savefig('output/recall_force.pdf', bbox_inches='tight')
# %%
