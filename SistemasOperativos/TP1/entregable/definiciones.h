#ifndef DEFINICIONES_H
#define DEFINICIONES_H

#define PRINT
#define RADIO 5

using namespace std;
enum direccion {NEUTRO=0, ARRIBA, ABAJO, IZQUIERDA, DERECHA};
typedef pair<int, int> coordenadas;
enum color {AZUL=0, ROJO,INDEFINIDO,VACIO,EMPATE,BANDERA_ROJA,BANDERA_AZUL};
enum estrategia {SECUENCIAL=0,RR,SHORTEST,PROXIMIDAD};

#endif /* DEFINICIONES_H */
