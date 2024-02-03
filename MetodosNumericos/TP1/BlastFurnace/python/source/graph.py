from turtle import shape
import numpy as np
from math import ceil, floor, pi
import matplotlib.pyplot as plt
import seaborn as sns

def read_input(instance, subinstance):
    r_i, R_e, m, n, iso, ninst = [line.strip() for line in open(f'../../input/{instance}/{subinstance}.in')][0].split(' ')
    r_i, R_e, m, n, iso, ninst = float(r_i), float(R_e), int(m), int(n), float(iso), int(ninst)
    return r_i, R_e, m, n, iso, ninst

def bilinear(instance, subinstance, mult_m = 2, mult_n = 2):
    r_i, R_e, m, n, iso, ninst = read_input(instance, subinstance)
    values = [float(line.strip()) for line in open(f'../../output/{instance}/{subinstance}.temp')]
    value_sets = [np.array(values[i*n*m:(i+1)*n*m]).reshape(m,n) for i in range(ninst)]
    output = open(f'../../output/{instance}/{subinstance}_interpolado.temp', 'w')
    for M in value_sets:
        delta_r = (R_e - r_i) / (m-1)
        delta_theta = 2*pi / n

        def bilinear(r, theta):
            r = ((r - r_i)/delta_r)
            theta = ((theta)/delta_theta)

            r_1, r_2 = max(r-1, 0) if floor(r) - r == 0 else floor(r), min(r+1, m-1) if ceil(r) - r == 0 else ceil(r)
            r_1, r_2 = int(r_1), int(r_2)

            theta_1 = floor(theta) if floor(theta) - theta == 0 else floor(theta)
            theta_2 = ceil(theta)+1 if ceil(theta) - theta == 0 else ceil(theta)
            theta_1, theta_2 = int(theta_1), int(theta_2)

            r_2_i     = m-1 if r_2     >= (m-1) else r_2
            theta_2_i = 0   if theta_2 >= n     else theta_2

            X = np.array([r_2 - r, r - r_1])
            Q = np.array([M[r_1, theta_1], M[r_1, theta_2_i], M[r_2_i, theta_1], M[r_2_i, theta_2_i],]).reshape((2, 2))
            Y = np.array([theta_2 - theta, theta - theta_1]).transpose()
            return (X @ Q @ Y)/((r_2 - r_1) * (theta_2 - theta_1))

        A = np.zeros((mult_m*m, mult_n*n), dtype=float)
        for i in range(mult_m*m):
            for j in range(mult_n*n):
                A[i,j] = bilinear(r_i+i*delta_r/mult_m, j*delta_theta/mult_n)

        for row in A:
            for e in row:
                output.write(str(e)+'\n')
    output.close()

def temp_graph(instance, subinstance, path=None):
    r_i, R_e, m, n, iso, ninst = read_input(instance, subinstance)
    theta = np.tile(np.linspace(0, 2*np.pi, n), (m, 1)).transpose()
    r = np.tile(np.linspace(r_i, R_e, m), (n, 1))
    values = [float(line.strip()) for line in open(f'../../output/{instance}/{subinstance}.temp')]
    value_sets = [values[i*n*m:(i+1)*n*m] for i in range(ninst)]
    for i in range(len(value_sets)):
        print(f'graficando la temperatura de {instance}, entrada numero {i+1} con {m} radios y {n} angulos')
        A = [value_sets[i][j:j+n] for j in range(0, len(value_sets[i]), n)]
        z = np.array(A).transpose()

        fig, ax = plt.subplots(subplot_kw={'projection': 'polar'})

        grafico = ax.pcolor(theta, r, z, cmap='jet', vmin = min(0, np.min(A)), vmax = max(1500, np.max(A)))
        ax.set_title('Alto horno')
        ax.set_yticklabels([])

        fig.colorbar(grafico)
        if path == None:
            plt.show()
        elif path != 'pass':
            plt.savefig(path)

def temp_graph_bilin(instance, subinstance, mult_m = 2, mult_n = 2, path=None):
    r_i, R_e, m, n, iso, ninst = read_input(instance, subinstance)
    values = [float(line.strip()) for line in open(f'../../output/{instance}/{subinstance}.temp')]
    value_sets = [np.array(values[i*n*m:(i+1)*n*m]).reshape(m,n) for i in range(ninst)]
    
    for M in value_sets:
        delta_r = (R_e - r_i) / (m-1)
        delta_theta = 2*pi / n

        def bilinear(r, theta):
            r = (r - r_i)/delta_r
            theta = (theta)/delta_theta
            r_1, r_2 = max(r-1, 0) if floor(r) - r == 0 else floor(r), min(r+1, m-1) if ceil(r) - r == 0 else ceil(r)
            r_1, r_2 = int(r_1), int(r_2)
            theta_1 = floor(theta) if floor(theta) - theta == 0 else floor(theta)
            theta_2 = ceil(theta)+1 if ceil(theta) - theta == 0 else ceil(theta)
            theta_1, theta_2 = int(theta_1), int(theta_2)
            r_2_i = m-1 if r_2 >= (m-1) else r_2
            theta_2_i = 0 if theta_2 >= n else theta_2
            X = np.array([r_2 - r, r - r_1])
            Q = np.array([M[r_1, theta_1],M[r_1, theta_2_i],M[r_2_i, theta_1],M[r_2_i, theta_2_i],]).reshape((2, 2))
            Y = np.array([theta_2 - theta, theta - theta_1]).transpose()
            return 1/((r_2 - r_1)*(theta_2 - theta_1)) * (X @ Q @ Y)

        theta = np.tile(np.linspace(0, 2*np.pi, n*mult_n), (m*mult_m, 1)).transpose()
        r = np.tile(np.linspace(r_i, R_e, m*mult_m), (n*mult_n, 1))
        A = np.zeros((mult_m*m, mult_n*n), dtype=float)
        for i in range(mult_m*m):
            for j in range(mult_n*n):
                A[i,j] = bilinear(r_i+i*delta_r/mult_m, j*delta_theta/mult_n)

        z = np.array(A).transpose()

        fig, ax = plt.subplots(subplot_kw={'projection': 'polar'})

        grafico = ax.pcolor(theta, r, z, cmap='jet', vmin = min(0, np.min(A)), vmax = max(1500, np.max(A)))
        ax.set_title('Alto horno')
        ax.set_yticklabels([])

        fig.colorbar(grafico)
        if path == None:
            plt.show()
        elif path != 'pass':
            plt.savefig(path)

def temp_graph_bilin2(instance, subinstance, mult_m = 2, mult_n = 2, path=None):
    r_i, R_e, m, n, iso, ninst = read_input(instance, subinstance)
    values = [float(line.strip()) for line in open(f'../../output/{instance}/{subinstance}.temp')]
    value_sets = [np.array(values[i*n*m:(i+1)*n*m]).reshape(m,n) for i in range(ninst)]
    
    for M in value_sets:
        delta_r = (R_e - r_i) / (m-1)
        delta_theta = 2*pi / n

        def bilinear(r, theta):
            r = (r - r_i)/delta_r
            theta = (theta)/delta_theta
            r_1, r_2 = max(r-1, 0) if floor(r) - r == 0 else floor(r), min(r+1, m-1) if ceil(r) - r == 0 else ceil(r)
            r_1, r_2 = int(r_1), int(r_2)
            theta_1 = floor(theta) if floor(theta) - theta == 0 else floor(theta)
            theta_2 = ceil(theta)+1 if ceil(theta) - theta == 0 else ceil(theta)
            theta_1, theta_2 = int(theta_1), int(theta_2)
            r_2_i = m-1 if r_2 >= (m-1) else r_2
            theta_2_i = 0 if theta_2 >= n else theta_2
            X = np.array([r_2 - r, r - r_1])
            Q = np.array([M[r_1, theta_1],M[r_1, theta_2_i],M[r_2_i, theta_1],M[r_2_i, theta_2_i],]).reshape((2, 2))
            Y = np.array([theta_2 - theta, theta - theta_1]).transpose()
            return 1/((r_2 - r_1)*(theta_2 - theta_1)) * (X @ Q @ Y)

        theta = np.tile(np.linspace(0, 2*np.pi, n*mult_n), (m*mult_m, 1)).transpose()
        r = np.tile(np.linspace(r_i, R_e, m*mult_m), (n*mult_n, 1))
        A = np.zeros((mult_m*m, mult_n*n), dtype=float)
        for i in range(mult_m*m):
            for j in range(mult_n*n):
                A[i,j] = bilinear(r_i+i*delta_r/mult_m, j*delta_theta/mult_n)

        z = np.array(A).transpose()

        fig, ax = plt.subplots(subplot_kw={'projection': 'polar'})

        grafico = ax.pcolor(theta, r, z, cmap='jet', vmin = 500, vmax = 1500)
        ax.set_title('Alto horno')
        ax.set_yticklabels([])

        fig.colorbar(grafico)
        if path == None:
            plt.show()
        elif path != 'pass':
            plt.savefig(path)

def iso_graph(instance, subinstance, path=None):
    r_i, R_e, m, n, iso, ninst = read_input(instance, subinstance)
    theta = np.linspace(0, 2*np.pi, n+1)
    values = [float(line.strip()) for line in open(f'../../output/{instance}/{subinstance}.iso')]
    value_sets = [values[i*n:(i+1)*n] for i in range(ninst)]
    for i in range(len(value_sets)):
        print(f'graficando la isoterma de {instance}, entrada numero {i+1} con {m} radios y {n} angulos')
        r = np.array([value_sets[i][j:j+n] + [value_sets[i][j]] for j in range(0, len(value_sets[i]), n)]).reshape(-1, 1)
        sns.set_theme()
        fig, ax = plt.subplots(subplot_kw={'projection': 'polar'})
        plt.ylim(r_i, R_e)
        ax.plot(theta, [r_i]*(n+1))
        ax.plot(theta, [R_e]*(n+1))
        ax.plot(theta, r)
        ax.set_rticks([x-1 for x in range(int(r_i)-1, int(R_e)+1)])
        ax.grid(True)
        ax.set(xlabel='n²', ylabel='tiempo(ns)')
        
        ax.set_title(f'Isoterma de {iso} grados')
        if path == None:
            plt.show()
        elif path != 'pass':
            plt.savefig(path)

def risk_graph(instance, subinstance):
    r_i, R_e, m, n, iso, ninst = read_input(instance, subinstance)
    theta = np.linspace(0, 2*np.pi, n+1)
    values = [float(line.strip()) for line in open(f'../../output/{instance}/{subinstance}.iso')]
    value_sets = [values[i*n:(i+1)*n] for i in range(ninst)]
    for i in range(len(value_sets)):
       return

def interpolated_iso_graph(instance, subinstance, mult_m = 2, mult_n = 2, path=None):
    r_i, R_e, m, n, iso, ninst = read_input(instance, subinstance)
    m *= mult_m
    n *= mult_n
    print(n)
    theta = np.linspace(0, 2*np.pi, n+1)
    values = [float(line.strip()) for line in open(f'../../output/{instance}/{subinstance}_interpolado.iso')]
    value_sets = [values[i*n:(i+1)*n] for i in range(ninst)]
    for i in range(len(value_sets)):
        print(f'graficando la isoterma de {instance}, entrada numero {i+1} con {m} radios y {n} angulos')
        r = np.array([value_sets[i][j:j+n] + [value_sets[i][j]] for j in range(0, len(value_sets[i]), n)]).reshape(-1, 1)
        sns.set_theme()
        fig, ax = plt.subplots(subplot_kw={'projection': 'polar'})
        plt.ylim(r_i, R_e)
        ax.plot(theta, [r_i]*(n+1))
        ax.plot(theta, [R_e]*(n+1))
        ax.plot(theta, r)
        ax.set_rticks([x-1 for x in range(int(r_i)-1, int(R_e)+1)])
        ax.grid(True)
        ax.set(xlabel='n²', ylabel='tiempo(ns)')
        
        ax.set_title(f'Isoterma de {iso} grados')
        if path == None:
            plt.show()
        elif path != 'pass':
            plt.savefig(path)