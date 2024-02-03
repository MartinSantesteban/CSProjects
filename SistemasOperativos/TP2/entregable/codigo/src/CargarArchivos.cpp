#ifndef CHM_CPP
#define CHM_CPP

#include <vector>
#include <iostream>
#include <fstream>
#include <thread>

#include "CargarArchivos.hpp"

int cargarArchivo(
    HashMapConcurrente &hashMap,
    std::string filePath
) {
    std::fstream file;
    int cant = 0;
    std::string palabraActual;

    // Abro el archivo.
    file.open(filePath, file.in);
    if (!file.is_open()) {
        std::cerr << "Error al abrir el archivo '" << filePath << "'" << std::endl;
        return -1;
    }
    while (file >> palabraActual) {
        hashMap.incrementar(palabraActual);
        cant++;
    }
    // Cierro el archivo.
    if (!file.eof()) {
        std::cerr << "Error al leer el archivo" << std::endl;
        file.close();
        return -1;
    }
    file.close();
    return cant;
}


void cargarMultiplesArchivos(
    HashMapConcurrente &hashMap,
    unsigned int cantThreads,
    std::vector<std::string> filePaths
) {
    std::atomic<int8_t> vanguard {0};
    std::vector<std::thread> threads(cantThreads);
    
    for (auto &t : threads)
        t = std::thread([&](){
            auto peek = std::atomic_fetch_add(&vanguard, 1);
            
            while (peek < (int)filePaths.size()) {
                cargarArchivo(hashMap, filePaths[peek]);
                peek = std::atomic_fetch_add(&vanguard, 1);
            }
        });

    for (auto &t : threads)
        t.join();
}

int cargarDirecto(
    HashMapConcurrente &hashMap,
    std::string filePath
) {
    std::fstream file;
    int cant = 0;
    std::string palabraActual;

    // Abro el archivo.
    file.open(filePath, file.in);
    if (!file.is_open()) {
        std::cerr << "Error al abrir el archivo '" << filePath << "'" << std::endl;
        return -1;
    }
    while (file >> palabraActual) {
        hashMap.cargar_par(make_pair(palabraActual, 1));
        cant++;
    }
    // Cierro el archivo.
    if (!file.eof()) {
        std::cerr << "Error al leer el archivo" << std::endl;
        file.close();
        return -1;
    }
    file.close();
    return cant;
}


void cargarMultiplesDirecto(
    HashMapConcurrente &hashMap,
    unsigned int cantThreads,
    std::vector<std::string> filePaths
) {
    std::atomic<int8_t> vanguard {0};
    std::vector<std::thread> threads(cantThreads);
    
    for (auto &t : threads)
        t = std::thread([&](){
            auto peek = std::atomic_fetch_add(&vanguard, 1);
            
            while (peek < (int)filePaths.size()) {
                cargarDirecto(hashMap, filePaths[peek]);
                peek = std::atomic_fetch_add(&vanguard, 1);
            }
        });

    for (auto &t : threads)
        t.join();
}

#endif
