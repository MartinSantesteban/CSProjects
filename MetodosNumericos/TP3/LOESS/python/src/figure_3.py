# %%
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
# %%
sns.set_style("ticks")
df = pd.read_csv("../data/dataset_multi.csv")
fig, axes = plt.subplots(4, 4, figsize=(8,8))
titles = ['Solar Radiation','Ozone','Temperature','Wind Speed']
attributes = ['radiation','ozone','temperature','wind']
text_locs = [(175,175),(0.5,0.5),(0.5,0.5),(11,11)]
ticks = [[0, 100, 200, 300],[0, 50, 100, 150],[60, 80, 100],[5, 10, 15, 20]]
axes_l = [(-10,350),(0,1),(0,1),(0,22)]


axes[3][2].set_xlim(55,100)
axes[2][3].set_ylim(55,100)
for (i, j) in [ (i, j) for i in range(4) for j in range(4)]:
    if i == j:
        #axes[i][j].set(xticks = [],yticks = [])
        axes[i][j].set(xlim=axes_l[i],ylim=axes_l[i])
        axes[i][j].text(text_locs[i][0],text_locs[i][1], titles[i], horizontalalignment='center', verticalalignment='center',weight = 'bold')
    if i == 1 or i == 2:
        axes[i][j].set_xticks([])
    else:
        axes[i][j].set(xticks=ticks[j])
        if i == 0:
            axes[i][j].xaxis.tick_top()
    if j == 1 or j == 2:
        axes[i][j].set_yticks([])
    else:
        axes[i][j].set(yticks=ticks[i])
        if j == 3:
            axes[i][j].yaxis.tick_right()
    
    if i != j:
        sns.scatterplot(data=df, x= attributes[j], y= attributes[i], ax=axes[i][j], linewidth=0 ,s=12.5, color="0", marker="o")
        axes[i][j].set_ylabel('')
        axes[i][j].set_xlabel('')
fig.subplots_adjust(wspace=0.025, hspace=0.025)

tuplas = [(0,0),(0,2),(1,3),(2,0),(3,1),(3,3)]
for (x,y) in tuplas:
    axes[x][y].set(yticklabels = [])
    axes[x][y].set(xticklabels = [])
sns.set(font = 'bold')
plt.savefig('../figures/figure_3.pdf',format = 'pdf')

# %%
