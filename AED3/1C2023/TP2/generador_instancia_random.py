import os
import random

## PARAMETROS A TENER EN CUENTA
casos = 100
limite_x = 50
limite_y = 50
N = 1000



input_folder = "inputs"
if not os.path.exists(input_folder):
    os.mkdir(input_folder)

def generar_oficinas(path, casos , limite_x, limite_y):
    for i in range(0,N,50):
        f = open(path + "/instancia_" + str(i)  , "w")
        f.write(str(casos) + "\n")
        for j in range(1,casos+1):
            R = random.randint(1,1001)
            V = random.randint(1,11)
            U = random.randint(1,V + 1)
            W = random.randint(1,N + 1)
            f.write(str(i) + " " + str(R) + " " + str(W) + " " + str(U) + " " + str(V) + "\n")
            for k in range(1,i):
                x = random.randint(0,limite_x)
                y = random.randint(0,limite_y)
                f.write(str(x) + " " + str(y) + "\n")
        f.close()

generar_oficinas(input_folder,casos,limite_x,limite_y)


