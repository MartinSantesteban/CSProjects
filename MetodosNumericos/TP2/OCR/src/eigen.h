#pragma once
#include "types.h"

enum StopCriterion {Iteration, VectorDelta, IsEigenValue};

double euclidean_distance(const Vector& A, const Vector& B);

/*
Calcula el autovalor (y autovector correspondiente) de módulo máximo

Parámetros:
----------

mat: const Matrix& mat
    Matriz sobre la que queremos calcular el autovalor

num_iter: unsigned (=5000 por defecto)
    Cantidad de iteraciones a correr

eps: double
    Tolerancia a residuo (opcional)

Devuelve:
--------

pair<double, Vector> donde el primer valor es el autovalor
y el segundo el autovector asociado
*/
std::pair<std::pair<double, Vector>,int>
    power_iteration(const Matrix& mat, StopCriterion = Iteration, unsigned max_iter=500, double eps=1e-10);


/*
Calcula

Parámetros:
----------

mat: const Matrix& mat
    Matriz sobre la que queremos calcular el autovalor

num: unsigned (=5000 por defecto)
    Cantidad de autovectores/autovalores a calcular

num_iter: unsigned (=5000 por defecto)
    Cantidad de iteraciones a correr

eps: double
    Tolerancia a residuo (opcional)
Devuelve:
--------

pair<Vector, Matrix> donde:
    - El primero elemento es un vector de los autovalores
    - El segundo elemento es una matriz cuyas columnas son los autovectores
      correspondientes
*/
std::pair<std::pair<Vector, Matrix>,int>
    get_first_eigenvalues(const Matrix& mat, unsigned num, StopCriterion = Iteration, unsigned num_iter=5000, double epsilon=1e-10);
