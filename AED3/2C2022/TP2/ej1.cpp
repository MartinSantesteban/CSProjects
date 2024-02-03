#include <iostream>
#include "vector"


/*
 * 1. Ejecutar DFS sobre el grafo para detectar puentes.
 * 2. Armar el subgrafo compuesto únicamente por los puentes.
 * 3. Detectar componentes conexas en dicho subgrafo.
 * 4. Si dos nodos pertenecen a la misma componente conexa, hay un único camino simple.
 *
 */


/// @brief Dado un nodo u, realiza la visita de dfs correspondiente. En primer lugar se establece el tiempo en que es descubierto. Luego se pasa a recorrer sus vecinos,
/// de forma tal que por cada vecino que sea descubierto se setea como su padre al nodo 'u'. Una vez revisada toda la lista de adyacencia, se termina de procesar el nodo.
/// @param ady lista de adyacencias
/// @param u nodo de origen
/// @param parent vector donde se almacenan los padres de cada nodo en el árbol DFS. Si parent[v] = u, entonces (u, v) es un tree-edge
/// @param discTime tiempo en el que se descubre un nodo
/// @param time tiempo global
/// @param color vector con los colores de cada nodo. Al finalizar el DFS, aquellos nodos en blanco no fueron alcanzables. Los nodos en negro fueron procesados.
void dfs_visit(const std::vector<std::vector<int>> &ady, int u, std::vector<int> &parent, std::vector<int> &discTime, int &time, std::vector<int> &color, std::vector<int> &cc, int component){
    time = time + 1;
    discTime[u] = time;
    color[u] = 1;
    cc[u] = component;
    for (auto v : ady[u]){
        if (color[v] == 0){
            parent[v] = u;
            dfs_visit(ady, v, parent, discTime, time, color, cc, component);
        }
    }
    color[u] = 2;
}


//PRE: 'parent', 'discTime' deben estar inicializados en -1. 'color' debe estar inicializado en 1 (blanco).
//hacemos que devuelva una lista con las raíces de cada árbol DFS.
/// @brief Ejecuta DFS a partir de un grafo representado por lista de adyacencia.
/// @param parent contiene los padres de cada nodo en el bosque DFS
/// @param discTime tiempo en que cada nodo es descubierto al hacer DFS
/// @param cc indica en que componente conexa está cada nodo, de forma tal que dos nodos u y v estan en la misma componente conexa sii cc[u] = cc[v]
/// @return un vector conteniendo las raices de los arboles en el bosque DFS.
std::vector<int> DFS(const std::vector<std::vector<int>> &ady, std::vector<int> &parent, std::vector<int> &discTime, std::vector<int> &color, std::vector<int> &cc){
    std::vector<int> treeRoots;
    int time = 0;
    int component = 0;
    for (int u = 0; u < ady.size(); u++){
        if (color[u] == 0){
            treeRoots.push_back(u);
            component++;
            parent[u] = u;
            dfs_visit(ady, u, parent, discTime, time, color, cc, component);
        }
    }
    return treeRoots;
}

/// @brief La cantidad de back-edges que cubren una arista (parent[u], u) es la cantidad de back-edges que salen de 'u' y van hacia arriba, mas la cantidad de back-edges
///que salen de los descendientes de u, menos la cantidad de back-edges que salen de descendientes de u y terminan en u.
///@returns retorna la cantidad de back-edges que cubren la arista (parent[u], u). Si dicha cantidad es 0, actualiza la info en 'bridgeParent'
int detectarPuentes(const std::vector<std::vector<int>> &ady, int u, std::vector<int> &parent, std::vector<int> &discTime, std::vector<bool> &bridgeParent){
    int cantidad = 0;
    for (auto v : ady[u]){
        if (parent[v] == u){    //por cada tree-edge hacia abajo le sumamos la cantidad de back-edges que lo cubren.
            cantidad += detectarPuentes(ady, v, parent, discTime, bridgeParent);
        } else {
            if (discTime[u] > discTime[v] && parent[u] != v){   //sumamos los back-edges que salen de u y van hacia arriba.
                cantidad++;
            }
            if (discTime[u] < discTime[v]){     //restamos los back-edges que llegan a u desde abajo.
                cantidad--;
            }
        }
    }
    if (cantidad == 0 && parent[u] != u)    //si no hay back-edges que cubran la tree-edge entre u y su padre, entonces es puente. Si u es raíz, no vale.
        bridgeParent[u] = true;

    return cantidad;
}


/// @brief Dado un vector de booleanos que indica los tree-edges que son puentes, retorna un grafo representado por lista de adyacencias compuesto únicamente por
/// las aristas puente.
std::vector<std::vector<int>> subgrafoPuentes(std::vector<int> &parent, std::vector<bool> &bridgeParent){
    std::vector<std::vector<int>> G(bridgeParent.size());
    for (int i = 0; i < bridgeParent.size(); i++){
        if (bridgeParent[i] && parent[i] != i){
            G[i].push_back(parent[i]);
            G[parent[i]].push_back(i);
        }
    }
    return G;
}

/// @brief Dado un grafo representado mediante lista de adyacencia, retorna un vector donde para cada nodo se indica a qué componente conexa pertenece en el subgrafo
/// que resulta de quedarse únicamente con las aristas puente del grafo original.
std::vector<int> compConexasEnPuentes(const std::vector<std::vector<int>> &ady, int R){
    std::vector<int> parent(R, -1);
    std::vector<int> discTime(R, -1);
    std::vector<int> color(R, 0);
    std::vector<int> cc(R, -1);
    std::vector<int> treeRoots = DFS(ady, parent, discTime, color, cc);      //corremos DFS para obtener la info necesaria para detectar puentes

    std::vector<bool> bridgeParent(R, false);
    for (auto u : treeRoots)
        detectarPuentes(ady, u, parent, discTime, bridgeParent);

    std::vector<std::vector<int>> soloPuentes = subgrafoPuentes(parent, bridgeParent);      //armamos el subgrafo compuesto únicamente por los puentes

    std::vector<int> parentPuentes(R, -1);
    std::vector<int> discTimePuentes(R, -1);
    std::vector<int> colorPuentes(R, 0);
    std::vector<int> ccPuentes(R, -1);
    DFS(soloPuentes, parentPuentes, discTimePuentes, colorPuentes, ccPuentes);      //corremos DFS sobre el subgrafo y observamos las comp. conexas

    return ccPuentes;
}

//lee los casos de test y ejecuta la funcion 'compConexasEnPuentes' para poder responder las consultas.
void executeTest(){
    int R, C, Q;
    while (std::cin >> R){
        if (R != 0){
            std::vector<std::vector<int>> ady(R);
            std::cin >> C >> Q;
            for (int i = 0; i < C; i++){
                int u, v;
                std::cin >> u >> v;
                u--; v--;
                ady[u].push_back(v);
                ady[v].push_back(u);
            }
            std::vector<int> compConexas = compConexasEnPuentes(ady, R);
            for (int i = 0; i < Q; i++){
                int u, v;
                std::cin >> u >> v;
                u--; v--;
                if (compConexas[u] == compConexas[v])
                    std::cout << "Y" << std::endl;
                else
                    std::cout << "N" << std::endl;
            }
            std::cout << "-" << std::endl;
        }
    }
}

int main() {
    executeTest();

     return 0;
}
