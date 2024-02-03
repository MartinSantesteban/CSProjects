# %%
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from multi_variable_loess import fit, single_variable_fit
# %%
data_original = pd.read_csv("../data/dataset_multi.csv")
data = data_original.loc[:,["radiation","temperature","wind"]]

def nuevo_ozono(x,y,z):
    return 2*x + y - z + np.random.normal(loc = 0.0, scale = 1, size = None)
col = []
for i in range(0,len(data)):
    [x,y,z] = data.iloc[i]
    col += [nuevo_ozono(x,y,z)]

data["ozono"] = col
## hacemos el loess, y para agregamos los residuos a los valores fitteados

xs = data.loc[:,["radiation","temperature","wind"]].to_numpy()
data["fitted_values"] = fit(xs,xs,data["ozono"], 0.4,1)
data["residuos"] = data["ozono"] - data["fitted_values"]
#%% Hacemos el qqplot para ver que efectivamente el error es normal, 
fig = sns.scatterplot(
    x = sps.norm.ppf(np.linspace(0.01, 0.99, len(data))),
    y = np.sort(data["residuos"]),
    s = 15, facecolor = 'None', linewidth = 1, edgecolor = 'k')
fig.set(xlabel='Normal Quantiles', ylabel='Residuals', xlim=(-3,3))
plt.savefig("../figures/exp_qqplot.pdf",bbox_inches = "tight")
# %% Graficamos los valores absolutos de los residuos vs los valores ajustados
fig = sns.scatterplot(data = data, x = "fitted_values", y = "residuos")
xs = data["fitted_values"].to_numpy()
ys = data["residuos"]
loess_nuevo = fit(xs.reshape(-1,1),xs.reshape(-1,1),ys,2/3,1)
df = pd.DataFrame(data = {"fitted_nuevos":loess_nuevo, "fitted_viejos":xs})
sns.lineplot(data = df, x = "fitted_viejos",y = "fitted_nuevos",color = "red")
plt.savefig("../figures/exp_residuals_vs_fitted.pdf",bbox_inches = "tight")
# %%
