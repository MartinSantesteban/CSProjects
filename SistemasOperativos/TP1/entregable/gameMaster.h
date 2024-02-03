#ifndef GAMEMASTER_H
#define GAMEMASTER_H
#include <tuple>
#include <cstdio>
#include <vector>
#include <atomic>
#include <algorithm>
#include <semaphore.h>
#include "definiciones.h"
#include "config.h"
#include "IO.h"

using namespace std;

class gameMaster {
private:
    #ifdef PRINT
    IO output;
    #endif
private:
    int nro_ronda = 0;
    int x, y, jugadores_por_equipos;
    int quantum, quantum_restante;
    color turno;
    coordenadas banderas[2];
    vector<vector<color>> tablero;
    vector<coordenadas>   posiciones_jugadores[2];
    estrategia strat;
	
    color obtener_coordenadas(coordenadas coord);
    void mover_jugador_tablero(coordenadas pos_anterior, coordenadas pos_nueva, color color_equipo);
 
public:
    vector<sem_t> equipos[2];
    sem_t         barrera;
public:
    color ganador = INDEFINIDO;
    gameMaster(Config config, string nombre, estrategia strat, int quantum);

    int ancho();
	int alto ();
    color en_posicion(coordenadas coord);
    coordenadas bandera(color equipo);

    bool es_posicion_valida(coordenadas pos);
    bool es_color_libre(color color_tablero);

    int jugador_mas_cercano(color equipo);
    pair<int,int> jugadores_proximidad(coordenadas c);

    int  mover_jugador(direccion dir, int nro_jugador);
    void termino_ronda(color equipo);
    bool termino_juego();
    
    static int distancia(coordenadas pair1, coordenadas pair2);
    coordenadas proxima_posicion(coordenadas anterior, direccion movimiento);

    void jugar();
};

#endif // GAMEMASTER_H
