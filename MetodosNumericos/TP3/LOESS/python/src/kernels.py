import numpy as np

def W(u, kernel):
    match kernel:
        case 'uniform':
            return 1 if -1 <= u < 1 else 0
        case 'triangle':
            return (1-np.abs(u)) if -1 <= u < 1 else 0
        case 'bicuadratic':
            return (1 - u**2)**2 if -1 <= u < 1 else 0
        case 'tricube':
            return (1 - np.abs(u**3))**3 if -1 <= u < 1 else 0
        case 'epanechnikov':
            return (3/4) * (1-u**2) if -1 <= u < 1 else 0
        case _:
            return 0