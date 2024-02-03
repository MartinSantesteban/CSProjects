# %%
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import metnum as mn
from time import process_time_ns

# %% 
cantidad_maxima_its_TOTALES = 40000 
cantidad_autovalores = 50
lim_promedio = 100
metric_data = pd.DataFrame(data = {'iteraciones':[],'difference_norm':[],'time':[]})
for sample in range(1,lim_promedio+1):
    X = X = pd.DataFrame(np.random.randint(0,100,size=(cantidad_autovalores, cantidad_autovalores)))
    S = X @ X.T
    [numpy_eigenvalues,numpy_eigenvectors] = np.linalg.eig(S)
    numpy_eigenvalues = sorted(list(numpy_eigenvalues),reverse = True)
    for i in range(0,cantidad_maxima_its_TOTALES+1,int(cantidad_maxima_its_TOTALES/20)): ## Hay que sacar un promedio si o si por el randomness del metpot
        ti = process_time_ns()
        [[eigenvalues,eigenvectors],total_iterations] =  mn.get_first_eigenvalues(S, cantidad_autovalores,mn.StopCriterion(0),int(i/cantidad_autovalores),1e-32)
        tf = process_time_ns()
        final_time = tf - ti
        difference_norm = (np.abs(eigenvalues - numpy_eigenvalues)).mean()
        metric_data = pd.concat([metric_data,pd.DataFrame(data = {'iteraciones' : [i], 'difference_norm' : [difference_norm],'time':[final_time]})],ignore_index = True)
    print("Sample: " + str(sample) + " done of " + str(lim_promedio))
metric_data.to_csv("output/experimento_cantidaditeraciones.csv")

# %% Graficos
metric_data = pd.read_csv("output/experimento_cantidaditeraciones.csv")
fig, axes = plt.subplots(1,3,figsize = (15,5))
sns.lineplot(data = metric_data,x = "iteraciones", y = "difference_norm",ax = axes[0])
metric_data = metric_data.loc[metric_data["iteraciones"]  > 10000]
sns.lineplot(data = metric_data,x = "iteraciones", y = "difference_norm",ax = axes[1])
metric_data = metric_data.loc[metric_data["iteraciones"]  > 30000]
sns.lineplot(data = metric_data,x = "iteraciones", y = "difference_norm",ax = axes[2])
for i in range(0,3):
    axes[i].set(ylabel = "Diferencia",xlabel = "Iteraciones")
    axes[i].grid()
plt.savefig("output/img_cantidad_iteraciones.pdf",bbox_inches = "tight")
#sns.lineplot(data = metric_data,x = "iteraciones", y = "time",ax = ax[1])
#ax[1].set(ylabel = "Tiempo(s)",xlabel = "Iteraciones")
#ax[0].grid()
#ax[1].grid()

# %% Grafico de tiempo
metric_data = pd.read_csv("output/experimento_cantidaditeraciones.csv")
metric_data["time"] /= 1e9
fig = sns.lineplot(data = metric_data,x = "iteraciones", y = "time")
fig.grid()
fig.set(ylabel = "Tiempo(s)",xlabel = "Iteraciones")
plt.savefig("output/img_cantidad_iteraciones_tiempos.pdf",bbox_inches = "tight")