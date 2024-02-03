#include <iostream>
#include <vector>
#include <queue>
#include <limits>
#include <math.h>
#define INF std::numeric_limits<int>::max()

typedef std::pair<int, int> infoDist;       //el primer elemento corresponde a la distancia computada. El segundo corresponde al nodo.

struct arista{
    int v;
    int peso;
};

//PRE: dist está inicializado con INF.
/// @brief Algoritmo de Dijkstra para calcular distancias minimas desde un nodo fuente.  Utiliza std::make_pair como implementacion de la cola de prioridad.
/// @param ady lista de adyacencias para representar el digrafo
/// @param s nodo fuente para calcular las distancias
/// @param dist vector de distancias donde se almacenan las distancias minimas
void Dijkstra(const std::vector<std::vector<arista>> &ady, int s, std::vector<int> &dist){
    dist[s] = 0;
    std::priority_queue<infoDist , std::vector<infoDist>, std::greater<infoDist>> Q;

    for (int v = 0; v < ady.size(); v++)
        Q.push(std::make_pair(dist[v], v));

    while(!Q.empty()){
        infoDist infoU = Q.top();
        Q.pop();
        int u = infoU.second;
        for (auto edge : ady[u]){
            int v = edge.v;
            int peso = edge.peso;
            if (dist[u] < INF && dist[v] > dist[u] + peso){
                dist[v] = dist[u] + peso;
                Q.push(std::make_pair(dist[v], v));
            }
        }
    }
}

/// @brief dada una lista de adyacencia y una capacidad C que modelan el problema, retorna la maxima ganancia del portero. Para ello, ejecuta el algoritmo de Dijkstra
/// desde el nodo 0, y luego calcula cuantas veces se puede hacer el recorrido minimo entre 0 y p+1 sin exceder la capacidad de la caja.
/// @param ady lista de adyacencia para representar el digrafo que modela el problema
/// @param C capacidad de la caja
/// @return un entero representando la ganancia maxima del portero
int gananciaMaxPortero(std::vector<std::vector<arista>> &ady, int C){
    std::vector<int> dist(ady.size(), INF);
    Dijkstra(ady, 0, dist);

    int recorridoMin = dist.back();
    if (recorridoMin >= C)
        return 0;
    int robado = ceil(((float)C - (float)recorridoMin) / ((float)recorridoMin - 1));

    if (recorridoMin >= C)
        return 0;

    return robado;
}



//lee los casos de test y ejecuta la funcion 'gananciaMaxPortero' para cada uno.
void executeTest(){
    int T;
    std::cin >> T;
    while (T > 0){
        int C, P;
        std::cin >> C >> P;
        std::vector<std::vector<arista>> ady(P+2);

        int cantPortero;
        std::cin >> cantPortero;
        for (int i = 0; i < cantPortero; i++){
            int feligres;
            std::cin >> feligres;
            ady[0].push_back({feligres, 0});
        }

        for (int i = 1; i <= P; i++){
            int cant;
            std::cin >> cant;
            for (int j = 0; j < cant; j++){
                int v, monedas;
                std::cin >> monedas >> v;
                if (v == 0)
                    v = P+1;
                ady[i].push_back({v, monedas});
            }
        }

        int gananciaMax = gananciaMaxPortero(ady, C);
        std::cout << gananciaMax << std::endl;
        T--;
    }

}


int main() {
    executeTest();

    return 0;
}
