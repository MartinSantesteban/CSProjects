# %%
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import metnum as mn
#%%
def eigenvector_to_image(x):
    plt.close("all")
    plt.xticks([])
    plt.yticks([])
    plt.imshow(x,cmap = "Greys",interpolation = "none")
    plt.savefig("output/visualizacion_avals.png",bbox_inches='tight')
    plt.show()

data = pd.read_csv("../data/train.csv")
X = data
X = X.iloc[:,1:]
X = (X - X.mean())/(len(X)-1)


Mx = X.T @ X
alpha = 5
[[eigenvalues, eigenvectors],total_iterations] = mn.get_first_eigenvalues(Mx,alpha,mn.StopCriterion(0),12,1e-8)
#for i in 
eigenvectors = [eigenvectors[:,i] for i in range(alpha)]
eigenvectors = [np.array(e).reshape(28,28) for e in eigenvectors]
eigenvectors = np.concatenate(eigenvectors,axis = 1)
eigenvector_to_image(eigenvectors)
# %%


