#include "equipo.h"
#include <assert.h>

direccion2 Equipo::obtener_direcciones(coordenadas posicion_jugador, coordenadas posicion_objetivo) {
	direccion2 dir;
	if (posicion_jugador.second > posicion_objetivo.second) dir.vertical   = ARRIBA;
	if (posicion_jugador.second < posicion_objetivo.second) dir.vertical   = ABAJO;
	if (posicion_jugador.first  > posicion_objetivo.first ) dir.horizontal = IZQUIERDA;
	if (posicion_jugador.first  < posicion_objetivo.first ) dir.horizontal = DERECHA;
	assert(posicion_objetivo.first != posicion_jugador.first || posicion_objetivo.second != posicion_jugador.second);
	return dir;
}

direccion Equipo::siguiente_movimiento(coordenadas posicion_jugador, coordenadas posicion_objetivo) {
	direccion2 dir = obtener_direcciones(posicion_jugador, posicion_objetivo);
	color proyeccion_horizontal = belcebu->en_posicion(belcebu->proxima_posicion(posicion_jugador, dir.horizontal));
	color proyeccion_vertical   = belcebu->en_posicion(belcebu->proxima_posicion(posicion_jugador, dir.vertical));
	
	bool horizontal = (proyeccion_horizontal == VACIO) || (proyeccion_horizontal == bandera_contraria);
	bool vertical   = (proyeccion_vertical   == VACIO) || (proyeccion_vertical   == bandera_contraria);

	timespec n;
	clock_gettime(CLOCK_REALTIME, &n);
	if (horizontal && vertical)
		return n.tv_nsec % 2 ? dir.horizontal : dir.vertical;
	else if (horizontal || vertical)
		return horizontal ? dir.horizontal : dir.vertical;
	for (int d = ARRIBA; d <= DERECHA; ++d)
		if (belcebu->es_posicion_valida(belcebu->proxima_posicion(posicion_jugador, (direccion)d)) &&
			belcebu->en_posicion(belcebu->proxima_posicion(posicion_jugador, (direccion)d)) == VACIO)
				return (direccion)d;
	return NEUTRO;
}

void Equipo::jugador(int nro_jugador) {
	while(	sem_wait(&(belcebu->equipos[equipo][nro_jugador]))  == 0  &&
			(strat != PROXIMIDAD || sem_wait(&belcebu->barrera) == 0) &&
			!belcebu->termino_juego()) {
		//CRIT
		if (strat == SECUENCIAL || strat == PROXIMIDAD)
			movimiento.lock();
		direccion dir = siguiente_movimiento(posiciones[nro_jugador], pos_bandera_contraria);
		int error = belcebu->mover_jugador(dir, nro_jugador);
		if (strat == SECUENCIAL || strat == PROXIMIDAD)
			movimiento.unlock();
		//ENDCRIT
		if (!error)
			posiciones[nro_jugador] = belcebu->proxima_posicion(posiciones[nro_jugador], dir);
		switch(strat) {
			case(SECUENCIAL):
				if (cant_jugadores <= ++cant_jugadores_que_ya_jugaron) {
					cant_jugadores_que_ya_jugaron = 0;
					belcebu->termino_ronda(equipo);
				}
				break;
			case(RR):
				if (--quantum_restante > 0)
					sem_post(&(belcebu->equipos[equipo][(nro_jugador+1) % cant_jugadores]));
				else {
					quantum_restante = quantum;
					belcebu->termino_ronda(equipo);
				}
				break;
			case(SHORTEST):
				belcebu->termino_ronda(equipo);
				break;
			case(PROXIMIDAD): {
					int energia_restante;
					sem_getvalue(&belcebu->equipos[equipo][nro_jugador], &energia_restante);
					if (!energia_restante && cant_jugadores <= ++cant_jugadores_que_ya_jugaron) {
						cant_jugadores_que_ya_jugaron = 0;
						belcebu->termino_ronda(equipo);
					}
				}
				break;
			default:
				break;
		}
	}
}

Equipo::Equipo(gameMaster *belcebu, color equipo, 
		estrategia strat, int cant_jugadores, int quantum, vector<coordenadas> posiciones) {
	this->belcebu        = belcebu;
	this->equipo         = equipo;
	contrario            = (equipo == ROJO) ? AZUL : ROJO;
	bandera_contraria    = (equipo == ROJO) ? BANDERA_AZUL : BANDERA_ROJA;
	this->strat          = strat;
	this->quantum        = quantum;
	quantum_restante     = quantum;
	this->cant_jugadores = cant_jugadores;
	this->posiciones     = posiciones;
}

void Equipo::comenzar() {
	pos_bandera_contraria = buscar_bandera_contraria(std::max(cant_jugadores, 16));
	for(int i = 0; i < cant_jugadores; ++i)
		sem_init(&(belcebu->equipos[equipo][i]), 0, 0);
	for(int i = 0; i < cant_jugadores; ++i)
		jugadores.emplace_back(thread(&Equipo::jugador, this, i));
}

void Equipo::terminar() {
	for(auto &t : jugadores)
		t.join();
}

void Equipo::buscar_bandera_jugador(int inicio, int cantidad, coordenadas& bandera){
	for(int i = inicio; i < inicio + cantidad; ++i) {
		coordenadas actual = {i / belcebu->alto(), i % belcebu->alto()};
		if(belcebu->en_posicion(actual) == bandera_contraria)
			bandera = actual;
	}
}

coordenadas Equipo::buscar_bandera_contraria(int cantidad_exploradores) {
	vector<thread> exploradores;
	coordenadas    bandera;
	
	unsigned int tablero                 = belcebu->ancho() * belcebu->alto();
	unsigned int casillas_por_explorador = tablero / cantidad_exploradores;
	unsigned int excedente               = tablero % cantidad_exploradores;
	unsigned int inicio                  = 0;
	
	for(int i = 0; i < cantidad_exploradores; ++i){
		exploradores.emplace_back(
				thread(&Equipo::buscar_bandera_jugador, this,
				inicio,
				casillas_por_explorador + (i < excedente),
				ref(bandera)
			));
		inicio += casillas_por_explorador + (i < excedente);
	}

	for(auto &t : exploradores)
		t.join();
	return bandera;
}
