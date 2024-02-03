#ifndef CHM_CPP
#define CHM_CPP

#include <thread>
// alternativamente #include <pthread.h>
#include <iostream>
#include <fstream>
#include <functional>
#include "HashMapConcurrente.hpp"
#include <semaphore.h>

sem_t semaforos[HashMapConcurrente::cantLetras];
std::mutex mutex;

HashMapConcurrente::HashMapConcurrente() {
    for (unsigned int i = 0; i < HashMapConcurrente::cantLetras; i++) {
        tabla[i] = new ListaAtomica<hashMapPair>();
        sem_init(&(semaforos[i]), 0, 1);
    }
}

unsigned int HashMapConcurrente::hashIndex(std::string clave) {
    return (unsigned int)(clave[0] - 'a');
}

void HashMapConcurrente::cargar_par(hashMapPair par) {
    uint key = hashIndex(par.first);
    sem_wait(&(semaforos[key]));
    auto lista = tabla[key];
    lista->insertar(par);
    sem_post(&(semaforos[key]));
}

void HashMapConcurrente::incrementar(std::string clave) {
    uint key = hashIndex(clave);
    sem_wait(&(semaforos[key]));
    auto lista = tabla[key];

    for (hashMapPair& hmp : *lista)
        if (hmp.first == clave) {
            hmp.second++;
            sem_post(&(semaforos[key]));
            return;
        }

    lista->insertar(make_pair(clave, 1));
    sem_post(&(semaforos[key]));
}

std::vector<std::string> HashMapConcurrente::claves() {
    std::vector<std::string> claves;
    for(auto &letra : tabla)
        for(auto &clave : *letra)
            claves.push_back(clave.first);
    return claves;
}

unsigned int HashMapConcurrente::valor(std::string clave) {
    uint key = hashIndex(clave);
    auto lista = tabla[key];
    for (hashMapPair hmp : *lista)
        if (hmp.first == clave)
            return hmp.second;
    return 0;
}

hashMapPair HashMapConcurrente::maximo() {
    hashMapPair *max = new hashMapPair();
    max->second = 0;

    for (int i = 0; i < HashMapConcurrente::cantLetras; ++i)
        sem_wait(&(semaforos[i]));

    for (unsigned int index = 0; index < HashMapConcurrente::cantLetras; index++) {
        for (auto &p : *tabla[index])
            if (p.second > max->second) {
                max->first = p.first;
                max->second = p.second;
            }
        sem_post(&(semaforos[index]));
    }

    return *max;
}

hashMapPair HashMapConcurrente::maximoParalelo(unsigned int cantThreads) {
    std::atomic<int8_t> vanguard {0};
    hashMapPair maximos[HashMapConcurrente::cantLetras];
    
    for (int i = 0; i < HashMapConcurrente::cantLetras; ++i)
        sem_wait(&(semaforos[i]));

    std::vector<std::thread> threads(cantThreads);
    for (auto &t : threads)
        t = std::thread([&](){
            auto peek = std::atomic_fetch_add(&vanguard, 1);
            
            while (peek < HashMapConcurrente::cantLetras) {
                for (auto &p : *tabla[peek])
                    if (p.second > maximos[peek].second)
                        maximos[peek] = p;
                sem_post(&(semaforos[peek]));
                peek = std::atomic_fetch_add(&vanguard, 1);
            }
        });

    for (auto &t : threads)
        t.join();
    
    for (int i = 1; i < HashMapConcurrente::cantLetras; ++i)
        if (maximos[i].second > maximos[0].second)
            maximos[0] = maximos[i];

    return maximos[0];
}

#endif
