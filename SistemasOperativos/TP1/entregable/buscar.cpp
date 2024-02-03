#include <iostream>
#include "gameMaster.h"
#include "equipo.h"
#include "definiciones.h"
#include "config.h"

using namespace std;

int main(int argc, char** argv) {
    if (argc < 3) {
        cout << "usage: <path> <samples>" << endl;
        return 0;
    }
    string nombre = argv[1];
    int samples = std::atoi(argv[2]);

    Config config = *(new Config(nombre));
	
    gameMaster belcebu = gameMaster(config, nombre, SECUENCIAL, 1);

	Equipo rojo(&belcebu, ROJO, SECUENCIAL, config.cantidad_jugadores, 1, config.pos_rojo);
	Equipo azul(&belcebu, AZUL, SECUENCIAL, config.cantidad_jugadores, 1, config.pos_azul);

    timespec i, f;
    double t;
    IO tiempo;
    tiempo.open("./python/output/tiempo_" + nombre + ".time");
    tiempo.write("time","threads");
    for (int n = 1; n <= 16; ++n) {
        for (int s = 0; s < samples; ++s) {
            clock_gettime(CLOCK_REALTIME, &i);
            rojo.buscar_bandera_contraria(n);
            clock_gettime(CLOCK_REALTIME, &f);
            t = ((double)f.tv_sec + 1.0e-9*f.tv_nsec) - ((double)i.tv_sec + 1.0e-9*i.tv_nsec);
            tiempo.write(t, n);
            clock_gettime(CLOCK_REALTIME, &i);
            azul.buscar_bandera_contraria(n);
            clock_gettime(CLOCK_REALTIME, &f);
            t = ((double)f.tv_sec + 1.0e-9*f.tv_nsec) - ((double)i.tv_sec + 1.0e-9*i.tv_nsec);
            tiempo.write(t, n);
        }
    }
}