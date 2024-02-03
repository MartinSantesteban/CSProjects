#ifndef MATRIZ_H
#define MATRIZ_H
#include<cassert>

#include"dimension.h"
#include"vector.h"
#include<iostream>
#include<functional>
#include<vector>

/**
 * @brief Matriz de numeros reales.
 */
class Matriz{
    public:
        Matriz();
        /**
         * @brief constructor por copia.
         * @param[in] M matriz a copiar.
         */
        Matriz(const Matriz& M);
        /**
         * @brief constructor de matriz nula de \p m por \p n.
         * @param[in] m cantidad de filas.
         * @param[in] n cantidad de columnas.
         */
        Matriz(int m, int n);
        /**
         * @brief constructor columna.
         * @param[in] V vector a trasponer.
         */
        Matriz(const Vector& V);
        /**
         * @brief constructor por arreglo de vectores.
         * @param[in] m cantidad de filas.
         * @param[in] n cantidad de columnas.
         * @param[in] VS puntero al primer vector.
         */
        Matriz(int m, int n, Vector** VS);
        /**
         * @brief constructor por arreglo de vectores stl.
         * @param[in] VS vectores.
         */
        Matriz(std::vector<std::vector<double>> VS);
        /**
         * @brief constructor por comprension.
         * @param[in] m cantidad de filas.
         * @param[in] n cantidad de columnas.
         * @param[in] f funcion (i, j) hacia A[i][j].
         */
        Matriz(int m, int n, std::function<double(int, int)> f);
        ~Matriz();

        Matriz& operator =  (const Matriz& B);
        bool    operator == (const Matriz& B) const;
        bool    operator != (const Matriz& B) const;
        Matriz& operator += (const Matriz& B);
        Matriz  operator +  (const Matriz& B) const;
        Matriz& operator -= (const Matriz& B);
        Matriz  operator -  (const Matriz& B) const;
        Matriz& operator *= (double scalar);
        Matriz  operator *  (double scalar) const;
        Matriz& operator /= (double scalar);
        Matriz  operator /  (double scalar) const;
        friend  Matriz operator *  (const double scalar, const Matriz& B);
        Matriz& operator *= (const Matriz& B);
        Matriz  operator *  (const Matriz& B) const;
        Vector  operator *  (const Vector& V) const;
        /**
         * @return La matriz traspuesta.
         */
        Matriz  t()  const;
        /**
         * @return La traza de la matriz.
         */
        double  tr() const;
        Vector& operator [] (int i) const;

        /**
         * @return La dimension de la matriz, dada como una tupla.
         */
        Dimension get_dimension() const;
        /**
         * @brief define la tolerancia para la comparacion entre dos matrices.
         */
        void set_tolerance(double tolerance);
        /**
         * @return La tolerancia utilizada para comparaciones.
         */
        double get_tolerance() const;

        /**
         * @param[in] b el vector que extendiende a la matriz.
         * @return La matriz extendida por el vector \p b.
         */
        Matriz extend(const Vector& b) const;
        /**
         * @param[in] f funcion a aplicar a todos los elementos de la matriz.
         */
        void apply(std::function<double(double)> f);

        /**
         * @return La matriz traspuesta del vector \p V.
         * @param[in] V Vector a trasponer.
         */
        static Matriz t(const Vector& V);
        /**
         * @param[in] m cantidad de filas.
         * @param[in] n cantidad de columnas.
         * @returns Matriz nula de \p m por \p n.
         */
        static Matriz zero(int m, int n);
        /**
         * @param[in] m cantidad de filas.
         * @param[in] n cantidad de columnas.
         * @returns Matriz con unos en toda posicion de \p m por \p n.
         */
        static Matriz one (int m, int n);
        /**
         * @returns Matriz identidad de \p n por \p n.
         * @param[in] n cantidad de filas y columnas.
         */
        static Matriz I (int n);
        /**
         * @param[in] m cantidad de filas.
         * @param[in] n cantidad de columnas.
         * @param[in] i fila donde se ubica el 1.
         * @param[in] j columna donde se ubica el 1.
         * @returns Matriz canonica \p i \p j de \p m por \p n.
         */
        static Matriz E (int n, int m, int i, int j);
        /**
         * @brief La matriz de canonica aisla la fila j-esima en la
         * fila i-esima cuando se multiplica por izquierda; o la
         * columna i-esima en la columna j-esima cuando se multiplica
         * por derecha.
         * @param[in] m cantidad de filas.
         * @param[in] n cantidad de columnas.
         * @param[in] i fila donde se ubica el 1.
         * @param[in] j columna donde se ubica el 1.
         * @returns Matriz de permutacion \p i \p j de \p m por \p n.
         */
        static Matriz P (int n, int i, int j);
        /**
         * @brief La matriz de permutacion permuta la fila i-esima con la fila j-esima
         * cuando se multiplica por izquierda; o la columna j-esima con la columna i-esima
         * cuando se multiplica por derecha.
         * @param[in] m cantidad de filas.
         * @param[in] n cantidad de columnas.
         * @param[in] p vector con el orden a permutar.
         * @returns Matriz de permutacion de \p m por \p n.
         */
        static Matriz P (int n, const Vector& p);
        /**
         * @overload
         */
        static Matriz P (int n, const std::vector<int>& p);
        /**
         * @param[in] n cantidad de filas y columnas.
         * @param[in] i fila/columna a colocar el multiplicador.
         * @param[in] a multiplicador.
         * @returns Matriz de multiplicacion de \p n por \p n con \p a en la fila/columna i-esima.
         */
        static Matriz M (int n, int i, int a);
        /**
         * @brief La matriz de transformacion suma la fila i-esima a la fila j-esima
         * cuando se multiplica por izquierda; o la columna j-esima a la columna i-esima
         * cuando se multiplica por derecha.
         * @param[in] n cantidad de filas y columnas.
         * @param[in] i fila a colocar el multiplicador.
         * @param[in] j columna a colocar el multiplicador.
         * @param[in] a multiplicador.
         * @returns Matriz de transformacion de \p n por \p n con \p a en la fila i-esima y columna j-esima.
         */
        static Matriz T (int n, int i, int j, int a);

        friend std::ostream& operator<< (std::ostream& os, const Matriz& V);

    private:
        Dimension _dim;
        Vector**  _values;
        double    _tolerance;

};

#endif//MATRIZ
