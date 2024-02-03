# %%

import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from multi_variable_loess import fit, single_variable_fit
# %%
def synthetic_function(x,varianza): ## Para este experimento usamos loess lineal
    return (1/np.sqrt(2))* x + np.sqrt(5) + np.random.normal(loc = 0.0, scale = varianza, size = None) ## scale = 9 para jugar (ds) 

def generate_synthetic_data(n,varianza):
    df = pd.DataFrame(data = {"v_ind":[], "v_dep":[]})
    for i in range(0,n):
        x = np.random.randint(150,250)
        df = pd.concat([df, pd.DataFrame(data = {"v_dep" : [x], "v_ind": [synthetic_function(x,varianza)]})],ignore_index = True)
    return df


fitted_values_df = pd.DataFrame(data = {"v_ind": [], "fitted_values":[], "f":[]})
fig, axes = plt.subplots(1,2,figsize = (15,7.5))
varianzas = [10,50]
for i in range(0,2):
    fitted_values_df = pd.DataFrame(data = {"v_ind" : [], "fitted_values":[], "f":[]})
    df =  generate_synthetic_data(100,varianzas[i])
    sns.scatterplot(data = df, x = "v_ind", y = "v_dep",ax = axes[i])
    xs = df["v_ind"].to_numpy().reshape(-1,1) ##si es una vd entonces hay que reshapear
    ys = df["v_dep"].to_numpy()
    for f in [0.05,0.25,0.5,0.99]:
        fitted_values = fit(xs,xs,ys,f,1)
        fitted_values_df = pd.concat([fitted_values_df, pd.DataFrame(data = {"v_ind": df["v_ind"], "fitted_values":fitted_values,"f":f})], ignore_index = True)
    sns.lineplot(data = fitted_values_df, x = "v_ind", y = "fitted_values", hue = "f", palette= ["#cfcfcf","C2","C3","black"], ax = axes[i])
    axes[i].set(xlabel = "x", ylabel = "f(x)")
sns.set_theme()
plt.savefig("../figures/img_experimento_f.pdf",bbox_inches='tight')
    





# %%
