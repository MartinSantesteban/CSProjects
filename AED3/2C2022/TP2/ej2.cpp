#include <iostream>
#include <vector>
#include <tuple>
#include <queue>
#include <limits.h>

int INFINITO = INT_MAX;
int T;                                  
int n;
int m;    
std::vector<std::tuple<int,int,int>> E; 


/// @brief Devuelve la cantidad de vértices de una componente conexa.
/// @param A Representante de la componente a contar en el vector de representantes.
/// @param representantes Vector de representantes, dado un nodo i, representantes[i] devuelve a que componente pertenece.
int cardinal(int A, std::vector<int> representantes){
    int res = 0;
    for(int i = 1; i < representantes.size(); i++)
        res = res + ((representantes[i] == A)?1:0);
    return res;
}


///@brief Dado el conjunto de aristas, le asigna a las matrices el peso correspondiente en cada posicion, cuando todas las componentes estan formadas por un solo nodo.
///@param aristas_maximas_componentes matriz que tiene en la posicion i,j el peso maximo entre las aristas que van de la componente i a la componente j. 
///@param aristas_minimas_componentes matriz que tiene en la posicion i,j el peso minimo entre las aristas que van de la componente i a la componente j. 
void construir_matrices_aristas(std::vector<std::vector<int>> &aristas_maximas_componentes, std::vector<std::vector<int>> &aristas_minimas_componentes, std::vector<std::tuple<int,int,int>> E){
    for(auto e: E){
        int a,b,w;
        std::tie(a,b,w) = e;
        aristas_maximas_componentes[a][b] = w;
        aristas_maximas_componentes[b][a] = aristas_maximas_componentes[a][b];
        aristas_minimas_componentes[a][b] = w;
        aristas_minimas_componentes[b][a] = aristas_minimas_componentes[a][b];
    }
}


///@brief Dado el conjunto de aristas de un grafo pesado, determina la sumatoria de la cantidad de vértices de las componentes candidatas.
int kruskal_inverso(){
    int res = 0;
    class operador{
        public:
            bool operator() (std::tuple<int,int,int> e1, std::tuple<int,int,int> e2){return std::get<2>(e1) < std::get<2>(e2);}
    };
    std::priority_queue<std::tuple<int,int,int>,std::vector<std::tuple<int,int,int>>,operador> Q;
    for(auto e : E){ Q.push(e);}                                                                  

    std::vector<int> representantes(n+1,0);
    for(int i = 0; i < n+1; i++){ representantes[i] = i;}                                         

    std::vector<int> aristas_minimas_internas(n+1,INFINITO);

    std::vector<std::vector<int>> aristas_minimas_componentes(n+1, aristas_minimas_internas);     
    std::vector<int> vacio(n+1, 0);
    std::vector<std::vector<int>> aristas_maximas_componentes(n+1, vacio);
    construir_matrices_aristas(aristas_maximas_componentes, aristas_minimas_componentes, E);

    while(!Q.empty()){   
        int u,v,peso;
        std::tie(u,v,peso) = Q.top();
        if(representantes[u] != representantes[v]){
            int A = representantes[u];
            int B = representantes[v];
            int representante_nuevo = std::min(A,B);
            int componente_a_borrar = std::max(A,B);

            int arista_minima_interna = std::min(std::min(aristas_minimas_internas[A], aristas_minimas_internas[B]), aristas_minimas_componentes[A][B]);

            for(int i = 1; i < n + 1; i++){
                if(representantes[i] == A || representantes[i] == B){
                    representantes[i] = representante_nuevo;
                    aristas_minimas_internas[i] = arista_minima_interna;
                }
                
                aristas_minimas_componentes[representante_nuevo][i] = std::min(aristas_minimas_componentes[A][i], aristas_minimas_componentes[B][i]);
                aristas_minimas_componentes[i][representante_nuevo] = aristas_minimas_componentes[representante_nuevo][i];
                aristas_maximas_componentes[representante_nuevo][i] = std::max(aristas_maximas_componentes[A][i], aristas_maximas_componentes[B][i]);
                aristas_maximas_componentes[i][representante_nuevo] = aristas_maximas_componentes[representante_nuevo][i];
            }
            
            for(int j = 0; j < n + 1; j++){
                aristas_maximas_componentes[componente_a_borrar][j] = 0;
                aristas_maximas_componentes[j][componente_a_borrar] = 0;
                aristas_minimas_componentes[componente_a_borrar][j] = INFINITO;
                aristas_minimas_componentes[j][componente_a_borrar] = INFINITO;
            }
            
            int arista_maxima_externa = 0;
            for(int i = 1; i < n + 1; i++){
                if(representante_nuevo != i)
                    arista_maxima_externa = std::max(aristas_maximas_componentes[representante_nuevo][i], arista_maxima_externa);
            }

            if(arista_minima_interna > arista_maxima_externa){ res += cardinal(representante_nuevo, representantes);}
        }
        Q.pop();
    }
    return res;
}                  


int main(){
    std::cin >> T;
    int i = 0;
    while(i < T){
        std::cin >> n;
        std::cin >> m;
        std::vector<int> vacio(n+1,0);
        std::vector<std::tuple<int,int,int>> adyacencias_vacias;
        E = adyacencias_vacias;
        for(int j = 0; j < m; j++){
            int v,w,k;
            std::cin >> v;
            std::cin >> w;
            std::cin >> k;
            std::tuple<int,int,int> e = std::make_tuple(v,w,k);
            E.push_back(e);
        }
        std::cout << kruskal_inverso() << std::endl;
        i++;
    }
    return 0;
}


