#include <sys/unistd.h>
#include <assert.h>
#include "gameMaster.h"

bool gameMaster::es_posicion_valida(coordenadas pos) {
	return (pos.first > 0) && (pos.first < x) && (pos.second > 0) && (pos.second < y);
}

bool gameMaster::es_color_libre(color color_tablero){
    return color_tablero == VACIO || color_tablero == INDEFINIDO;
}

color gameMaster::en_posicion(coordenadas coord) {
	return tablero[coord.first][coord.second];
}

coordenadas gameMaster::bandera(color equipo) {
	assert(equipo == ROJO || equipo == AZUL);
	return banderas[equipo];
}

int gameMaster::ancho() {
	return x;
}

int gameMaster::alto() {
	return y;
}

int gameMaster::distancia(coordenadas c1, coordenadas c2) {
    return abs(c1.first - c2.first) + abs(c1.second - c2.second);
}

int gameMaster::jugador_mas_cercano(color equipo) {
	auto it = std::min_element(posiciones_jugadores[equipo].begin(), posiciones_jugadores[equipo].end(), 
		[this, &equipo](coordenadas &lhs, coordenadas &rhs) -> bool {
			return distancia(lhs, banderas[!int(equipo)]) < distancia(rhs, banderas[!int(equipo)]);
		}
	);
	return distance(posiciones_jugadores[equipo].begin(), it);
}

pair<int,int> gameMaster::jugadores_proximidad(coordenadas c){
	int jugadores_azules = 0;
	int jugadores_rojos  = 0;

	for(int i = c.first - RADIO; i < c.first + RADIO; ++i)
		for(int j = c.second - RADIO ; j < c.second +  RADIO; ++j) {
			if(es_posicion_valida({i, j}) && tablero[i][j] == AZUL)  
				jugadores_azules++;
			if(es_posicion_valida({i, j}) && tablero[i][j] == ROJO)
				jugadores_rojos++;
		}
	return {jugadores_azules, jugadores_rojos};
}


coordenadas gameMaster::proxima_posicion(coordenadas anterior, direccion movimiento) {
	switch(movimiento) {
		case(ARRIBA):
			anterior.second--; 
			break;
		case(ABAJO):
			anterior.second++;
			break;
		case(IZQUIERDA):
			anterior.first--;
			break;
		case(DERECHA):
			anterior.first++;
			break;
	}
	return anterior;
}

gameMaster::gameMaster(Config config, string nombre, estrategia strat, int quantum) {
	assert(config.x > 0);
	assert(config.y > 0);

    x = config.x;
	y = config.y;

	assert(       (config.bandera_roja.first == 1));
	assert(es_posicion_valida(config.bandera_roja));

	assert(     (config.bandera_azul.first == x-1));
	assert(es_posicion_valida(config.bandera_azul));

	assert(config.pos_rojo.size() == config.cantidad_jugadores);
	assert(config.pos_azul.size() == config.cantidad_jugadores);

	for(auto &coord : config.pos_rojo)
		assert(es_posicion_valida(coord));

	for(auto &coord : config.pos_azul)
		assert(es_posicion_valida(coord));
	
	jugadores_por_equipos   = config.cantidad_jugadores;
	banderas[ROJO]          = config.bandera_roja;
	banderas[AZUL]          = config.bandera_azul;
    posiciones_jugadores[1] = config.pos_rojo;
    posiciones_jugadores[0] = config.pos_azul;

	tablero.resize(x);
    for (int i = 0; i < x; ++i) {
        tablero[i].resize(y);
        fill(tablero[i].begin(), tablero[i].end(), VACIO);
    }

    for(auto &coord : config.pos_rojo){
        assert(es_color_libre(tablero[coord.first][coord.second]));
        tablero[coord.first][coord.second] = ROJO;
    }

    for(auto &coord : config.pos_azul){
        assert(es_color_libre(tablero[coord.first][coord.second]));
        tablero[coord.first][coord.second] = AZUL;
    }

	assert(es_color_libre(tablero[config.bandera_roja.first][config.bandera_roja.second]));
    tablero[config.bandera_roja.first][config.bandera_roja.second] = BANDERA_ROJA;
	assert(es_color_libre(tablero[config.bandera_azul.first][config.bandera_azul.second]));
    tablero[config.bandera_azul.first][config.bandera_azul.second] = BANDERA_AZUL;

	this->strat         = strat;
	this->quantum       = quantum;
	quantum_restante = 0;
	equipos[ROJO] = vector<sem_t> (jugadores_por_equipos);
	equipos[AZUL] = vector<sem_t> (jugadores_por_equipos);
	sem_init(&barrera, 0, 0);

	#ifdef PRINT
	string path = "./output/" + nombre;
	output.open(path);
	output.write({x, y});
	output.write(jugadores_por_equipos);
	output.write(config.bandera_roja);
	output.write(config.bandera_azul);
	for (int i = 0; i < posiciones_jugadores[ROJO].size(); ++i)
		output.write(posiciones_jugadores[ROJO][i]);
	for (int i = 0; i < posiciones_jugadores[AZUL].size(); ++i)
		output.write(posiciones_jugadores[AZUL][i]);
	#endif
	
    cout << "SE HA INICIALIZADO GAMEMASTER CON EXITO" << endl;
}

void gameMaster::mover_jugador_tablero(coordenadas pos_anterior, coordenadas pos_nueva, color color_equipo){
    assert(es_color_libre(tablero[pos_nueva.first][pos_nueva.second]));
    tablero[pos_anterior.first][pos_anterior.second] = VACIO; 
    tablero[pos_nueva.first   ][pos_nueva.second   ] = color_equipo;
}

int gameMaster::mover_jugador(direccion dir, int nro_jugador) {
	coordenadas proyeccion_posicion = proxima_posicion(posiciones_jugadores[turno][nro_jugador], dir);
	assert(es_posicion_valida(proyeccion_posicion)); 
	assert(dir == NEUTRO || en_posicion(proyeccion_posicion) == VACIO || en_posicion(proyeccion_posicion) == BANDERA_AZUL || en_posicion(proyeccion_posicion) == BANDERA_ROJA);

	#ifdef PRINT
	output.write(posiciones_jugadores[turno][nro_jugador], proyeccion_posicion, (turno ? "rojo" : "azul"));
	#endif

	--quantum_restante;
	tablero[posiciones_jugadores[turno][nro_jugador].first][posiciones_jugadores[turno][nro_jugador].second] = VACIO;
	tablero[proyeccion_posicion.first][proyeccion_posicion.second] = turno;
	posiciones_jugadores[turno][nro_jugador] = proyeccion_posicion;

	if (proyeccion_posicion == banderas[!int(turno)]){
		ganador = turno;
		for (int i = 0; i < jugadores_por_equipos; ++i)
				sem_post(&barrera);
		for (sem_t &sem : equipos[ROJO])
				sem_post(&sem);
		for (sem_t &sem : equipos[AZUL])
				sem_post(&sem);
		#ifdef PRINT
		output.close();
		#endif
	}
	return 0;
}

void gameMaster::termino_ronda(color equipo) {
	assert(turno == equipo);
	assert(quantum_restante == 0);

	turno = color(!turno);
	switch(strat) {
		case(SECUENCIAL):
			quantum_restante = jugadores_por_equipos;
			for (sem_t &sem : equipos[turno])
				sem_post(&sem);
			break;
		case(RR):
			quantum_restante = quantum;
			sem_post(&equipos[turno][0]);
			break;
		case(SHORTEST):
			quantum_restante = 1;
			sem_post(&equipos[turno][jugador_mas_cercano(turno)]);
			break;
		case(PROXIMIDAD):
			quantum_restante = 0;
			for (int i = 0; i < jugadores_por_equipos; ++i) {
				auto jugadores = jugadores_proximidad(posiciones_jugadores[turno][i]);
				int quantum_jugador = std::max(	quantum +
												(turno ? jugadores.second : jugadores.first) -
												(turno ? jugadores.first : jugadores.second) - 1, 1);
				quantum_restante += quantum_jugador;
				for (int j = 0; j < quantum_jugador; ++j)
					sem_post(&equipos[turno][i]);
			}
			int quantum_total = quantum_restante;
			for (int i = 0; i < quantum_total; ++i)
				sem_post(&barrera);
			break;
	}
}	

bool gameMaster::termino_juego() {
	return ganador != INDEFINIDO;
}

void gameMaster::jugar() {
	turno = AZUL;
	termino_ronda(AZUL);
}