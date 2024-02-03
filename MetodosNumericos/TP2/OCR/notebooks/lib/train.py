from matplotlib.transforms import Transform
import numpy as np
import pandas as pd
import metnum as mn
import sklearn.metrics as sk
from sklearn.model_selection import KFold, StratifiedKFold
from time import process_time_ns
import time

def metrics(labels, predicted,recall_class): 
    unsure = sum(predicted == -1)/predicted.size                                  
    accuracy  = sk.accuracy_score(labels, predicted)
    ## En precision y recall sacamos el primero que sklearn va a tener la clase del -1 en cuenta.
    precision = sk.precision_score(labels, predicted, average=None, zero_division=0)
    recall    = sk.recall_score(labels, predicted, average=None)
    if len(precision) == 11 :
        recall    = recall[1:]
        precision = precision[1:]
    recall    = recall if sum(recall_class) < 1e-4 else np.array([recall[i] for i in range(0,len(recall_class)) if recall_class[i] != 0])
    recall    = recall.mean()
    precision = precision.mean()
    return pd.DataFrame(data = {'accuracy': [accuracy], 'precision': [precision], 'recall': [recall],'unsure': [unsure]})
    
def train(data, n, K, alpha, k, p = 0, recall_classes = np.array([0] * 10)):
    subset_labels = data.iloc[:n,0]
    subset_data   = data.iloc[:n,1:n]

    kfold = StratifiedKFold(K, shuffle=False)
    pca = mn.PCA(alpha)

    metric_data = pd.DataFrame(data = {'n': [], 'K': [], 'alpha': [], 'k': [], 'accuracy': [], 'precision': [], 'recall': []})
    current_K = 1
    for train, test in kfold.split(subset_data, subset_labels):
        print(time.strftime("%H:%M:%S", time.localtime()) + f'   α:{alpha}, {current_K}/{K}', flush=True)
        train_labels = subset_labels.iloc[train].to_numpy()
        train_data   = subset_data  .iloc[train].to_numpy()
        
        ti = process_time_ns()
        if alpha > 0:
            pca.fit(train_data)
        tf = process_time_ns()
        time_pca = tf - ti
        for i in ([k] if type(k) == int else k):
            knn = mn.KNNClassifier(i)
            knn.fit(train_labels, train_data, pca)

            test_labels = subset_labels.iloc[test].to_numpy()
            test_data   = subset_data  .iloc[test].to_numpy()
            ti = process_time_ns()
            predictions = knn.predict(test_data,p, recall_classes)
            tf = process_time_ns()
            time_knn = tf - ti

            metrics_df = metrics(test_labels, predictions, recall_classes)
            metrics_df['n']        = [n]
            metrics_df['K']        = [K]
            metrics_df['alpha']    = [alpha]
            metrics_df['k']        = [i]
            metrics_df['time_pca'] = [time_pca]
            metrics_df['time_knn'] = [time_knn]
            metrics_df['p'] = [p]
            metric_data = pd.concat([metric_data, metrics_df], ignore_index=True)
        current_K += 1
        
    return metric_data