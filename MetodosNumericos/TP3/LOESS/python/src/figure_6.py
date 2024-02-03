# %%
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from multi_variable_loess import fit, single_variable_fit
# %%
data = pd.read_csv(f'../data/dataset_multi.csv')
data['ozone'] = np.cbrt(data['ozone'])
rs = [50, 170, 290]
ts = list(range(60, 95, 1))
ws = [5, 10, 15]

xis = data[['radiation', 'temperature', 'wind']].to_numpy()
xis = (xis - np.mean(xis, axis = 0)) / np.std(xis, axis = 0)

plt.rcParams["axes.linewidth"] = 2
fig, axes = plt.subplots(3, 3, figsize=(5.5, 5.5))
for i, j in [(i, j) for i in range(3) for j in range(3)]:
    axes[i][j].xaxis.set_tick_params(width=2)
    axes[i][j].yaxis.set_tick_params(width=2)
    xs = pd.DataFrame([[rs[i], t, ws[j]] for t in ts])
    xs.columns = ['radiation', 'temperature', 'wind']
    for col in xs:
        xs[col] = (xs[col] - np.mean(data[col])) / np.std(data[col])
    ys = fit(xs.to_numpy(),xis, data['ozone'], 0.8, 2)
    sns.lineplot(x=ts, y=ys, ax=axes[i][j], color='k')
    axes[i][j].set(ylim=(0, 7.5),
        xticks=[60, 70, 80, 90],
        yticks=[1, 4, 7])
fig.subplots_adjust(wspace=0.1, hspace=0.1)

axes[0][2].text(110, 3.75, '50', ha = 'right', va = 'center')
axes[1][2].text(110, 3.75, '170', ha = 'right', va = 'center')
axes[2][2].text(110, 3.75, '290', ha = 'right', va = 'center')

fig.text(0.50, 1.00, 'Wind Speed', size = 12, ha = 'center', va = 'center')
fig.text(1.05, 0.50, 'Solar Radiation', size = 12, ha = 'center', va = 'center', rotation = 'vertical')
fig.text(0.50, 0.05, 'Temperature', size = 12, ha = 'center', va = 'center')
fig.text(0.05, 0.50, 'Cube Root Ozone', size = 12, ha = 'center', va = 'center', rotation = 'vertical')

axes[0][0].text(77, 9.5, '5', ha = 'center', va = 'center')
axes[0][1].text(77, 9.5, '10', ha = 'center', va = 'center')
axes[0][2].text(77, 9.5, '15', ha = 'center', va = 'center')

axes[0][1].set(yticks=[])
axes[1][0].set(xticks=[])
axes[1][1].set(xticks=[], yticks=[])
axes[1][2].set(xticks=[])
axes[2][1].set(yticks=[])

axes[0][0].xaxis.tick_top()
axes[0][1].xaxis.tick_top()
axes[0][2].xaxis.tick_top()
axes[0][2].yaxis.tick_right()
axes[1][2].yaxis.tick_right()
axes[2][2].yaxis.tick_right()

axes[0][0].set(xticklabels=[])
axes[0][1].set(xticklabels=[])
axes[0][2].set(xticklabels=[])
axes[0][2].set(yticklabels=[])
axes[1][2].set(yticklabels=[])
axes[2][2].set(yticklabels=[])
## tenemos la fila 1 y 3 dadas vueltas!!!
plt.savefig('../figures/figure_6.pdf',format = 'pdf',bbox_inches='tight')
# %%