# %%
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from multi_variable_loess import fit, single_variable_fit
# %% Figure 5 - Cleveland 1988
#TODO twin ticks
fig, ax = plt.subplots(1,3,figsize=(15,20))
v_independiente = ['radiation','temperature','wind']
data = pd.read_csv(f'../data/dataset_multi.csv')
xs = data[['radiation', 'temperature', 'wind']].to_numpy()
data['ys']       = fit(xs, xs, data['ozone'], 2/3, 1)
data['Residuals'] = data['ozone'] - data['ys']
for i in range(0, len(v_independiente)):
    sns.scatterplot(data = data, x = v_independiente[i], y = 'Residuals',facecolor = 'None',edgecolor = 'k', ax=ax[i])
    data['loess']     = single_variable_fit(data[v_independiente[i]], data['Residuals'], 2/3, 1)
    sns.lineplot(data = data, x = v_independiente[i], y = 'loess', color='k', ax = ax[i])
    ax[i].set_aspect(np.ptp(data[v_independiente[i]]) / np.ptp(data['Residuals']))
plt.savefig('../figures/figure_f5_1988_horizontal.pdf',bbox_inches='tight',format = 'pdf')
# %%