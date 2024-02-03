from cmath import pi
import numpy as np

def generate(instance, subinstance, r_i, R_e, m, n, iso, ninst, fs_i, fs_e):
    f = open(f'../../input/{instance}/{subinstance}.in', 'w')
    f.write(f'{r_i} {R_e} {m} {n} {iso} {ninst}\n')
    print(f'generando {ninst} instancias de {instance}, con {m} radios y {n} angulos')
    for i in range(ninst):
        T_i, T_e = [], []
        for theta in [2*pi*k/n for k in range(n)]:
            T_i += [fs_i[i](theta)]
            T_e += [fs_e[i](theta)]
        for e in T_i+T_e:
            f.write(str(e)+' ')
        f.write('\n')
    f.close()