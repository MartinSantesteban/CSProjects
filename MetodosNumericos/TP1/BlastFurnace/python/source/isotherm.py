from tkinter import N
import numpy as np
import matplotlib.pyplot as plt
from math import ceil, floor, pi

def read_data(instance, subinstance):
    f = open(f"../../output/{instance}/{subinstance}.temp","r")
    (r_i, R_e, m, n, iso, ninst) = [line.strip() for line in open(f'../../input/{instance}/{subinstance}.in')][0].split(' ')
    (r_i, R_e, m, n, iso, ninst) = (float(r_i), float(R_e), int(m), int(n), float(iso), int(ninst))
    values = [float(line.strip()) for line in open(f'../../output/{instance}/{subinstance}.temp')]
    value_sets = [np.array(values[i*n*m:(i+1)*n*m]).reshape(m, n) for i in range(ninst)]
    return (r_i, R_e, m, n, iso, ninst, value_sets)

def isotherm_abs (instance, subinstance):
    (r_i, R_e, m, n, iso, ninst, value_sets) = read_data(instance, subinstance)
    delta_r = (R_e - r_i) / (m-1)
    isos = []
    for M in value_sets:
        iso_actual = []
        for c in range(M.shape[1]):
            columna = M[:,c]
            in_actual   = 0
            temp_actual = columna[0]
            for i in range(M[:,c].size):
                if( abs(columna[i]-iso) - 1.0e-6 <= abs(temp_actual-iso)):
                    in_actual = i
                    temp_actual = columna[i]
            iso_actual += [r_i + in_actual * delta_r]
        isos += [iso_actual]
    output = open(f'../../output/{instance}/{subinstance}.iso', 'w')
    for I in isos:
        for e in I:
            output.write(str(e)+'\n')
    output.close()
    return

def isotherm_linear (instance, subinstance):
    (r_i, R_e, m, n, iso, ninst, value_sets) = read_data(instance, subinstance)
    delta_r = (R_e - r_i) / (m-1)
    isos = []
    for M in value_sets:
        iso_actual = []
        for columna in [M[:,c] for c in range(M.shape[1])]:
            center = np.argmin(np.abs(columna-iso))
            top = min(center + 1, m-1)
            bot = max(center - 1, 0)
            if center != top and (columna[center] <= iso <= columna[top] or columna[top] <= iso <= columna[center]):
                t = (iso - columna[top])/(columna[center] - columna[top])
                r = center * t + top * (1-t)
                iso_actual += [r_i + r * delta_r]
            elif center != bot and (columna[bot] <= iso <= columna[center] or columna[center] <= iso <= columna[bot]):
                t = (iso - columna[bot])/(columna[center] - columna[bot])
                r = center * t + bot * (1-t)
                iso_actual += [r_i + r * delta_r]
            else:
                iso_actual += [r_i + center * delta_r]
        isos += [iso_actual]
    output = open(f'../../output/{instance}/{subinstance}.iso', 'w')
    for I in isos:
        for e in I:
            output.write(str(e)+'\n')
    output.close()
    return

def isotherm_linear2 (instance, subinstance):
    (r_i, R_e, m, n, iso, ninst, value_sets) = read_data(instance, subinstance)
    delta_r = (R_e - r_i) / (m-1)
    isos = []
    for M in value_sets:
        iso_actual = []
        for columna in [M[:,c] for c in range(n)]:
            below = np.array(np.asarray(columna-iso < 0).nonzero())
            if len(below) == 0:
                return r_i if abs(columna[0] - iso) < abs(columna[-1] - iso) else R_e
            a = np.argmin(np.abs(below-iso))
            if a > 0 and a < m-1:
                b = a+1
                iso_actual += [((r_i + b * delta_r) - (r_i + a * delta_r)) * (iso -  columna[a]) / (columna[b] - columna[a]) + (r_i + a * delta_r)]
            else:
                iso_actual += [r_i + a * delta_r]
        isos += [iso_actual]
    output = open(f'../../output/{instance}/{subinstance}.iso', 'w')
    for I in isos:
        for e in I:
            output.write(str(e)+'\n')
    output.close()
    return

def isotherm_bilinear (instance, subinstance, mult_m = 2, mult_n = 2):
    (r_i, R_e, m, n, iso, ninst) = [line.strip() for line in open(f'../../input/{instance}/{subinstance}.in')][0].split(' ')
    (r_i, R_e, m, n, iso, ninst) = (float(r_i), float(R_e), int(m), int(n), float(iso), int(ninst))
    n *= mult_n
    m *= mult_m
    values = [float(line.strip()) for line in open(f'../../output/{instance}/{subinstance}_interpolado.temp')]
    value_sets = [np.array(values[:n*m]).reshape(m, n) for i in range(ninst)]
    delta_r = (R_e - r_i) / (m-1)
    isos = []
    for M in value_sets:
        iso_actual = []
        for columna in [M[:,c] for c in range(M.shape[1])]:
            center = np.argmin(np.abs(columna-iso))
            top = min(center + 1, m-1)
            bot = max(center - 1, 0)
            if center != top and (columna[center] <= iso <= columna[top] or columna[top] <= iso <= columna[center]):
                t = (iso - columna[top])/(columna[center] - columna[top])
                center = center * t + top * (1-t)
            elif center != bot and (columna[bot] <= iso <= columna[center] or columna[center] <= iso <= columna[bot]):
                t = (iso - columna[bot])/(columna[center] - columna[bot])
                center = center * t + bot * (1-t)
            iso_actual += [r_i + (center+0.75) * delta_r]
        isos += [iso_actual]
    output = open(f'../../output/{instance}/{subinstance}_interpolado.iso', 'w')
    for I in isos:
        for e in I:
            output.write(str(e)+'\n')
    output.close()
    return