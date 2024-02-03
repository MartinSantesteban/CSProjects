#ifndef SOLVER_H
#define SOLVER_H
#include<cassert>

#include"types/matriz.h"
#include"types/LU.h"
#include<iostream>
#include<functional>
#include<vector>

/**
 * @brief Clase estatica con metodos para la resolucion de sistemas.
 */
class Solver {
    public:
        /**
         * @brief Triangula a \p A mediante eliminacion gaussiana sin pivote.
         * @param[inout] A matriz a triangular.
         */
        static void GE(Matriz& A);
        /**
         * @brief Calcula la factorizacion LU de una matriz \p A.
         * @param[in] A matriz a factorizar.
         * @returns Puntero a la factorizacion LU de \p A.
         */
        static LU* FactorLU(const Matriz& A);
        /**
         * @brief Calcula el resultado del sistema \p A \p x = \p b utilizando eliminacion gaussiana.
         * @param[in] A matriz del sistema.
         * @param[in] b vector independiente.
         * @returns Solucion al sistema.
         */
        static Vector SolveGE(const Matriz& A, const Vector& b);
        /**
         * @brief Calcula el resultado del sistema \p A \p x = \p b utilizando eliminacion gaussiana.
         * @param[in] A factorizacion LU de la matriz.
         * @param[in] b vector independiente.
         * @returns Solucion al sistema.
         */
        static Vector SolveLU(const LU& A, const Vector& b);
    private:
        /**
         * @brief Calcula el resultado del sistema \p A \p x = \p L \p U \p x = \p b 
         * aprovechando el hecho que \p U es triangular superior.
         * @param[in] A factorizacion LU.
         * @returns Solucion al sistema.
         */
        static Vector SolveUpperTriangular(const LU& A, const Vector& b);
        /**
         * @brief Calcula el resultado del sistema \p A \p x = \p L \p U \p x = \p b 
         * aprovechando el hecho que \p U es triangular inferior.
         * @param[in] A factorizacion LU.
         * @returns Solucion al sistema.
         */
        static Vector SolveLowerTriangular(const LU& A, const Vector& b);
};

#endif//SOLVER