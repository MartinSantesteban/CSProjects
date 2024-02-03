#ifndef EQUIPO_H
#define EQUIPO_H

#include <semaphore.h>
#include <vector>
#include <thread>
#include <mutex>
#include <atomic>
#include <algorithm>
#include "definiciones.h"
#include "gameMaster.h"


using namespace std;

struct direccion2 {
	direccion horizontal = NEUTRO;
	direccion vertical   = NEUTRO;
};

class Equipo {
	private:
		gameMaster *belcebu; 
		color contrario, equipo, bandera_contraria;
		estrategia strat;
		int cant_jugadores, quantum, quantum_restante, jugador_mas_cercano;
		vector<thread> jugadores;
		atomic<int> cant_jugadores_que_ya_jugaron {0};
		vector<coordenadas> posiciones;
		coordenadas pos_bandera_contraria;

		direccion2 obtener_direcciones(coordenadas posicion_jugador, coordenadas posicion_objetivo);
		direccion siguiente_movimiento(coordenadas posicion_jugador, coordenadas posicion_objetivo);

		void buscar_bandera_jugador(int inicio, int cantidad, coordenadas& bandera);
		void jugador(int nro_jugador);
		mutex movimiento;

	public:
		Equipo(gameMaster *belcebu, color equipo, 
				estrategia strat, int cant_jugadores, int quantum, vector<coordenadas> posiciones);
		coordenadas buscar_bandera_contraria(int cantidad_exploradores);
		void comenzar();
		void comenzar_ronda();
		void terminar();
};
#endif // EQUIPO_H
