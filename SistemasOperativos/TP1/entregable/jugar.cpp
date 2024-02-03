#include <iostream>
#include "gameMaster.h"
#include "equipo.h"
#include "definiciones.h"
#include "config.h"

using namespace std;

int main(int argc, char** argv) {
    if (argc < 4) {
        cout << "usage: <path> <strat code> <quantum>" << endl;
        return 0;
    }
    string nombre = argv[1];

    estrategia strat = estrategia(std::atoi(argv[2]));
    int quantum = std::atoi(argv[3]);

    Config config = *(new Config(nombre));
	
    gameMaster belcebu = gameMaster(config, nombre, strat, quantum);
 
	Equipo rojo(&belcebu, ROJO, strat, config.cantidad_jugadores, quantum, config.pos_rojo);
	Equipo azul(&belcebu, AZUL, strat, config.cantidad_jugadores, quantum, config.pos_azul);

    rojo.comenzar();
    azul.comenzar();
    belcebu.jugar();
	rojo.terminar();
	azul.terminar();

    cout << "Bandera capturada por el equipo "<< (belcebu.ganador ? "rojo" : "azul") << ". Felicidades!" << endl;
}