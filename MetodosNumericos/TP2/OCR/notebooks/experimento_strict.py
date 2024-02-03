# %% 
import pandas as pd
import numpy as np
import sklearn as sk
import matplotlib.pyplot as plt
import seaborn as sns
from lib import train
import sklearn.metrics as sk
# %%        
data = pd.read_csv('../data/train.csv')
#%%
n = 20000
k = 20
K = 3
alpha = 13

# %%
metric_data = pd.DataFrame(data = {'K': [], 'alpha': [], 'k': [], 'accuracy': [], 'precision': [], 'recall': []})
for i in range(0,11):
    precision = 0.1 * i
    print(precision)
    metric_data = pd.concat([metric_data,train.train(data=data, n=n, K=K, alpha=alpha, k=k,p = precision)],ignore_index = True)
metric_data.to_csv(f'output/exp_strict.csv')
# %%
data = pd.read_csv(f'output/exp_strict.csv')
print(data)
fig,ax = plt.subplots()
ax1 = sns.lineplot(data=data, x='p', y='accuracy')
ax2 = sns.lineplot(data=data, x='p', y='precision')
ax3 = sns.lineplot(data=data, x='p', y='recall')
ax4 = sns.lineplot(data=data, x='p', y='unsure')
plt.savefig('output/exp_strict.pdf', bbox_inches='tight')

# %%
data = pd.read_csv(f'output/exp_strict.csv')
data.plot(x='p', y=['precision','recall','unsure'],kind = 'line')
plt.grid()
plt.legend(['Precision','Recall','Unsure'])
plt.ylabel("Métricas")
plt.xlabel("Grado de estrictez")
plt.savefig('output/exp_strict.pdf', bbox_inches='tight')

# %%
