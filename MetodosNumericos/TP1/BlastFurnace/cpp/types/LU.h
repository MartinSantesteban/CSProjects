#ifndef LU_H
#define LU_H
#include<cassert>

#include"matriz.h"
#include<iostream>
#include<functional>
#include<vector>

class Solver;
/**
 * Estructura que contiene la factorizacion LU de una matriz.
 * 
 * La factorizacion LU de una matriz es tal que si A es una matriz
 * A = LU donde L es triangular inferior con 1's en la diagonal y U es
 * triangular superior.
 */
struct LU {
    public:
        friend class Solver;
        /**
         * @returns El componente triangular inferior.
         */
        Matriz lower()  const;
        /**
         * @returns El componente triangular superior.
         */
        Matriz upper()  const;
        /**
         * @returns La matriz combinada dada por L + U - I.
         */
        Matriz matrix() const;

    private:
        LU(Matriz* L, Matriz* U);
        Matriz* _L;
        Matriz* _U;
};

#endif//LU
