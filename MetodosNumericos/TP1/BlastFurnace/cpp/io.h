#include<cassert>

#include<iostream>
#include<iomanip>
#include<fstream>
#include<vector>
#include <chrono>
#include <thread>

#include"blast_furnace.h"

/**
 * @brief Interfaz para la escritura y lectura del problema.
 */
class IO {
    public:
        IO();
        /**
         * @brief Lee los datos de un problema en el \p path dado.
         * @param[in] path path relativo al archivo de entrada.
         * @param[inout] BF instancia del horno inicializada con los datos leidos.
         * @param[inout] T_is arreglo de \p ninst vectores, conteniendo las temperaturas.
         * de la pared interna correspondiente a la i-esima instancia en la posicion i.
         * @param[inout] T_es arreglo de \p ninst vectores, conteniendo las temperaturas.
         * de la pared externa correspondiente a la i-esima instancia en la posicion i.
         * @param[inout] ninst cantidad de instancias a resolver.
         * @param[inout] iso valor de la isoterma a buscar.
         */
        void read(const std::string& path, BlastFurnace& BF, std::vector<Vector>& T_is, std::vector<Vector>& T_es, int* ninst, double* iso) const;
        /**
         * @brief Escribe un vector solucion por \p ninst en \p path.
         * @param[in] path path relativo al archivo de salida.
         * @param[in] ninst cantidad de instancias resueltas.
         * @param[in] O arreglo de matrices a escribir en la salida.
         */
        int write_temp(const std::string& path, int ninst, Matriz* O) const;
        /**
         * @brief libera los tiempos viejos en \p path.
         * @param[in] path path relativo al archivo de salida.
         */
        int clear_time(const std::string& path) const;
        /**
         * @brief Registra un tiempo de corrida del algoritmo en \p path.
         * @param[in] path path relativo al archivo de salida.
         * @param[in] duration duracion a registrar.
         */
        int write_time(const std::string& path, std::chrono::_V2::system_clock::duration duration) const;
        /**
         * @brief Escribe un vector solucion por \p ninst en \p path.
         * @param[in] path path relativo al archivo de salida.
         * @param[in] ninst cantidad de instancias resueltas.
         * @param[in] O arreglo de isotermas a escribir en la salida.
         */
        int write_iso(const std::string& path, int ninst, Vector* O) const;
};