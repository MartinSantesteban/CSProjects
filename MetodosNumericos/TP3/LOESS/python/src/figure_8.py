
# %%
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from multi_variable_loess import fit, single_variable_fit

# %% FIG 8
print("FIGURA 8")
l = 22
data = pd.read_csv(f'../data/dataset_multi.csv')
data['ozone'] = np.cbrt(data['ozone'])
D = {}
for var in ['radiation','temperature','wind']:
    D[var] = (data[var].mean(), data[var].std())
    data[var] = (data[var] - data[var].mean()) / data[var].std()
fig, axes = plt.subplots(3, 3, figsize=(5.5,5.5))
temperaturas = [62,76,90]
solar_radiation = [50,170,290]
for i in range(0,3):
    for j in range(0,3):
        xs = pd.DataFrame({'radiation': solar_radiation[2-i], 'temperature': temperaturas[j], 'wind': range(l+1)}) 
        for var in ['radiation', 'temperature', 'wind']:
            xs[var]  = (xs[var] - D[var][0]) / D[var][1]
        ys = fit(xs.to_numpy(), data[['radiation', 'temperature', 'wind']].to_numpy(), data['ozone'], 0.8, 2)
        sns.lineplot(x = range(l+1), y = ys, ax = axes[i][j], color = 'k')
        axes[i][j].set(yticks=[1,4,7],ylim = (0,7.25) ,xticks = [4,8,12,16],xlim = (3,19))
fig.text(0.06,0.5, 'Cube Root Ozone', ha = 'center', va = 'center', rotation = 'vertical')
fig.text(0.5,0.06, 'Wind Speed', ha = 'center', va = 'center')
fig.text(0.5,0.94, 'Temperature', ha = 'center', va = 'center')
for i in range(0,3):
    fig.text(0.24 + i * 0.275 ,0.90, temperaturas[i], ha = 'center', va = 'center')
    fig.text(0.94 ,0.24 + i * 0.265, solar_radiation[i], ha = 'center', va = 'center')
fig.text(1,0.5, 'Solar Radiation', ha = 'center', va = 'center', rotation = 'vertical')

plt.savefig('../figures/figure_8_1988.pdf',format = 'pdf', bbox_inches='tight')
# %%