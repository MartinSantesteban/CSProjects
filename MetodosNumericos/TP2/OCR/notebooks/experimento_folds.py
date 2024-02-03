# %%
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import metnum as mn
from lib import train
from time import process_time_ns
# %%
data = pd.read_csv("../data/train.csv")
n_list = [500,10000]
alpha = 13
k = 5
lista_K = [2,5,10,25,50]
#%%
metric_data = pd.DataFrame(data = {'n': [], 'K': [], 'alpha': [], 'k': [], 'accuracy': [], 'precision': [], 'recall': [],"tiempoTotal":[]})
for n in n_list:
    for K in lista_K:
        ti = process_time_ns()
        df = train.train(data=data, n=n, K=K, alpha=alpha, k=k)
        tf = process_time_ns()
        df["tiempoTotal"] = tf - ti
        metric_data = pd.concat([metric_data, df], ignore_index=True)
        print("K = " + str(K) + " listo ;; n = " + str(n))
    print(str(n) + " listo")
print(metric_data)
metric_data.to_csv(f'output/exp_folds.csv')
# %%
metric_data = pd.read_csv(f'output/exp_folds.csv')
sns.lineplot(data = metric_data, x = "K", y = 'accuracy',hue = "n",palette=["C0", "C1"], ci = None)
plt.grid()
plt.savefig("output/img_experimento_folds.pdf", bbox_inches='tight')
# %% Graficamos los tiempos
metric_data = pd.read_csv(f'output/exp_folds.csv')
sns.lineplot(data = metric_data, x = "K", y = 'tiempoTotal',hue = "n",palette=["C0", "C1"])
plt.grid()
plt.savefig("output/img_experimento_folds_tiempos.pdf", bbox_inches='tight')
