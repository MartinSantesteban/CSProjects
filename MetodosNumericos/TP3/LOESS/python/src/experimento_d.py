# %%
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from multi_variable_loess import fit, single_variable_fit

# %%

def función_sintética(x,funcion,varianza):
    if funcion == 1 :
        return (1/np.sqrt(2))* x + np.sqrt(5) + np.random.normal(loc = 0.0, scale = varianza, size = None)
    else:
        return  (x-4)**3 +4*(x-4)**2 + (x - 4) + np.random.normal(loc = 0.0, scale = varianza, size = None)

def synthetic_data(n,funcion,varianza):
    xs = [np.random.uniform(0,6) for i in range(0,n)]
    ys = [función_sintética(xi,funcion,varianza) for xi in xs]
    return [xs,ys]


n = 100             ##subir mucho pq puede generar matrices singulares
varianza = 50
f = 0.5
funciones = ["lineal","cuadratica"]
sns.set_theme()
fig, axes = plt.subplots(1,2,figsize = (10,5))
metric_data = pd.DataFrame(data = {"xs" : [], "fitted_values" : [],"residuos":[],"gradoRegresion":[], "case" : []})
for caso in range(1,3): 
    [xs_l,ys_l] = synthetic_data(n,caso,varianza)
    xs = np.array(xs_l)
    ys = np.array(ys_l)
    scatter_data = pd.DataFrame(data = {"xs":xs, "ys":ys})
    sns.scatterplot(data = scatter_data, x = "xs", y = "ys", ax = axes[caso-1])
    for grado in range(1,3):
        fitted_values = fit(xs.reshape(-1,1),xs.reshape(-1,1),ys,f,grado)
        metric_data = pd.concat([metric_data, pd.DataFrame({"xs" : xs, "fitted_values" : fitted_values,"residuos" : [ys[i] - fitted_values[i] for i in range(0,len(xs))] ,"gradoRegresion" : funciones[grado-1],"case" : funciones[caso-1]})],ignore_index = True)
    metric_data_sliced = metric_data.loc[metric_data["case"] == funciones[caso-1]] ##metric data tiene todo, aca lo grafico para el caso que toca
    sns.lineplot(data = metric_data_sliced, x = "xs",y = "fitted_values",hue = "gradoRegresion",ax = axes[caso - 1])
axes[0].set(xlabel = "x", ylabel = "f(x)")
axes[1].set(xlabel = "x", ylabel = "g(x)")
plt.savefig("../figures/img_experimento_d_values.pdf",bbox_inches='tight')

# %% graficamos los residuos <- residuos vs fitted
listaGrados = ["lineal","cuadratica"]
fig, axes = plt.subplots(2,2,figsize = (10,10))
for i in range(0,2):                                            ##por funcion(caso) <- 1 es lineal
    for j in range(0,2):                                        ##por regresion
        df = metric_data.loc[metric_data["case"] == funciones[i]]
        df = df.loc[df["gradoRegresion"] == funciones[j]]
        sns.scatterplot(data = df, x = "fitted_values", y = "residuos", ax = axes[i][j])
        ## Hacemos loess univariado por cada grafico
        xs = df["fitted_values"].to_numpy()
        fit_loess = fit(xs.reshape(-1,1),xs.reshape(-1,1),df["residuos"],0.5,1)
        df_loess = pd.DataFrame(data = {"xs" : xs,"ys" : fit_loess})
        sns.lineplot(data = df_loess, x = "xs", y = "ys", color = "black", ax = axes[i][j])
        axes[i][j].set(xlabel = "Valores ajustados", ylabel = "Residuos")
plt.subplots_adjust(wspace=0.25, hspace=0.25)
axes[0][0].title.set_text('Regresión lineal, f(x)')
axes[0][1].title.set_text('Regresión cuadrática, f(x)')
axes[1][0].title.set_text('Regresión lineal, g(x)')
axes[1][1].title.set_text('Regresión cuadrática, g(x)')
plt.savefig("../figures/img_experimento_d_residuos.pdf",bbox_inches='tight')
# %%
