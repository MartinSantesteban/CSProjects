#ifndef BLASTFURNACE_H
#define BLASTFURNACE_H
#include<cassert>

#include"solver.h"
#include<math.h>
#include<iostream>
#include<functional>
#include<vector>

#define _USE_MATH_DEFINES

/**
 * @brief Alto Horno, admite metodos para la resolucion
 * del sistema por metodos de eliminacion gaussiana y
 * factorizacion LU.
 */
class BlastFurnace{
    public:
        /**
         * @brief Metodos de resolucion.
         * @example asdasdasd
         * 
         */
        enum Method {
            M_EG = 0, //Metodo de resolucion por eliminacion Gausiana.
            M_LU = 1  //Metodo de resolucion por factorizacion LU.
        };

        /**
         * @brief constructor del horno nulo.
         */
        BlastFurnace() = default;
        /**
         * @brief constructor de un horno.
         * @param[in] r_i radio interno.
         * @param[in] R_e radio externo.
         * @param[in] m cantidad de radios discretizados (mas uno).
         * @param[in] n cantidad de angulos discretizados.
         */
        BlastFurnace(double r_i, double R_e, int m, int n);
        /**
         * @param[in] i radio del punto ancla.
         * @param[in] j angulo del punto ancla.
         * @param[in] r_k radio del punto a calcular.
         * @param[in] theta_k angulo del punto a calcular.
         * @returns el coeficiente del punto \p r_k \p theta_k en la ecuacion de laplace
         * centrada en el punto \p i \p j.
         */
        double coef(int i, int j, int r_k, int theta_k);

        /**
         * @param[in] T_i vector de temperaturas internas.
         * @param[in] T_e vector de temperaturas externas.
         * @param[in] target temperatura de la isoterma.
         * @param[in] M metodo a utilizar para resolver el sistema.
         * @returns El vector conteniendo los radios para cada angulo
         * en el cual se encuentra la isoterma de \p target grados centigrados.
         */
        Vector isotherm (const Vector& T_i, const Vector& T_e, double target, Method M);
        /**
         * @param[in] T_i vector de temperaturas internas.
         * @param[in] T_e vector de temperaturas externas.
         * @param[in] M metodo a utilizar para resolver el sistema.
         * @returns La matriz de temperaturas conteniendo en la posicion \p i \p j
         * la temperatura del punto radio i-esimo y angulo j-esimo de la
         * discretizacion.
         */
        Matriz solve_temperatures (const Vector& T_i, const Vector& T_e, Method M);

        /**
         * @brief Dado un angulo fijo, diferencia en metros entre un punto de la discretizacion y el anterior/siguiente.
         */
        double delta_r() const;
        /**
         * @brief Dado un radio fijo, diferencia en radianes entre un punto de la discretizacion y el anterior/siguiente.
         */
        double delta_theta() const;

    private:
        int _m;
        int _n;

        /**
         * @brief Radio interno.
         */
        double _r_i;
        /**
         * @brief Radio externo.
         */
        double _R_e;
        /**
         * @brief distancia entre un radio y el anterior/siguiente.
         */
        double _delta_r;
        /**
         * @brief distancia entre un angulo y el anterior/siguiente en radianes.
         */
        double _delta_theta;
        /**
         * @brief temperatura en el horno, donde la posicion \p i \p j representa el radio i-esimo en el angulo j-esimo.
         */
        Matriz _system;
        /**
         * @brief factorizacion LU de la matriz del sistema.
         */
        LU*    _LU;
        /**
         * @brief vector que contiene los coeficientes a multiplicar por T_i en el sistema.
         */
        Vector _b_i;
        /**
         * @brief vector que contiene los coeficientes a multiplicar por T_e en el sistema.
         */
        Vector _b_e;
};

#endif//BLASTFURNACE