#include <iostream>
#include <vector>
#include <cmath>
#include <iomanip>
#include <cfloat>

int C,N,R,W,U,V;

struct arista{
    int u; 
    int v;
    double peso;
};

std::vector<std::vector<double>> M;
std::vector<std::pair<int, int>> posiciones;
std::vector<bool> es_representante;
std::vector<double> minima_arista_componente; 

// FUNCIONES PARA DEBUGGEAR 
// ----------------------------------------------------------

void print_arista(arista e){
    std::cout << "( " << e.u << " , " << e.v << " , " << e.peso << " )";
}

template <typename T>
void print_matriz(std::vector<std::vector<T>> M){
    std::cout << std::endl;
    for(int i = 0; i < M.size(); i++){
        for(int j = 0; j < M.size(); j++){
            std::cout << M[i][j] << " ";
        }
        std::cout << std::endl;
    }
    std::cout << std::endl;
}

template <typename T>
void print_vector(std::vector<T> V){
    for(int i = 0; i < V.size(); i++){
        std::cout << V[i] << " " ;
    }
    std::cout << std::endl;
}

void print_conjunto_aristas( std::vector<arista> A){
    for(int i = 0; i < A.size(); i++){
        print_arista(A[i]); 
        std::cout << ", " << std::endl;
    }
}

// ----------------------------------------------------------

double distancia(int u,int v){      
           
    int u_x = posiciones[u].first;
    int u_y = posiciones[u].second;
    int v_x = posiciones[v].first;
    int v_y = posiciones[v].second;
    
    double a = (std::abs(u_x - v_x));
    double b = (std::abs(u_y - v_y));
    //if( a == 0 && b == 0) std::cout << "!" << u << " , " << v << std::endl;
    return std::sqrt((a * a) + (b * b));
}

void inicializacion_union_find(){
    std::vector<double> pesos_vacios(N,DBL_MAX);
    minima_arista_componente = pesos_vacios;
    std::vector<bool> vacio_bool(N, true);
    es_representante = vacio_bool;

    for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            if(j != i){
                minima_arista_componente[i] = std::min(minima_arista_componente[i],M[i][j]);
            }
        }
    }
    //print_vector(minima_arista_componente);
    //print_matriz();
}


std::vector<arista> kruskal(){
    std::vector<arista> arbol_vacio(N - W,{-1,-1,-1});
    std::vector<arista> AGM = arbol_vacio;

    for(int i = 0; i < N - W; i++){ 

        arista minima_arista = {-1,-1,DBL_MAX};
        for(int j = 0; j < N; j++){
            if(es_representante[j] && minima_arista_componente[j] < minima_arista.peso){        // <--- Estas agrupando las componentes en un solo nodo, con las minimas aristas entre los agrupados. Cuando iteras buscando el minimo, estás teniendo en cuenta TODAS las aristas de la componente conexa!
                minima_arista.u = j;
                minima_arista.peso = minima_arista_componente[j];
            }
        }   
        
        for(int j = 0; j < N; j++){
            if(M[minima_arista.u][j] == minima_arista.peso && es_representante[j]){
                minima_arista.v = j;
                break;
            }
        }

        AGM[i] = minima_arista; 

        int u = minima_arista.u; 
        int v = minima_arista.v;

        int representante_ganador = std::max(u,v);
        int representante_perdedor = std::min(u,v);

        es_representante[representante_perdedor] = false;
        
        // Unimos las dos componentes, agrupandolas en un solo nodo! Por eso cambiamos M
        for(int j = 0; j < N; j++){
            if(j != u && es_representante[j]){ 
                M[representante_ganador][j] = std::min(M[representante_ganador][j],M[representante_perdedor][j]); 
                M[j][representante_ganador] = M[representante_ganador][j];
            }
        }

        double peso_min = DBL_MAX;
        for(int j = 0; j < N; j++){
            if(es_representante[j] && j != representante_ganador && M[representante_ganador][j] < peso_min){
                peso_min = M[representante_ganador][j];
            }
        }
        minima_arista_componente[representante_ganador] = peso_min;

        /*
        int wop = 0;
        std::cout << "Next?" << std::endl;
        std::cin >> wop;
        if(wop){
            std::cout << "Matriz: " << std::endl;
            print_matriz();

            std::cout << "Representantes: " << std::endl;
            print_vector(es_representante);

            std::cout << "Minima arista componente: " << std::endl;
            print_vector(minima_arista_componente);
        }
        */

    }
    return AGM;
}



int main(){
    std::cin >> C;
    int indice = 1;
    while(indice <= C){
        std::cin >> N >> R >> W >> U >> V;
        
        std::vector<std::pair<int,int>> posiciones_vacias(N,std::make_pair(-1,-1));
        posiciones = posiciones_vacias;

        std::vector<double> fila_vacia(N,-1);
        std::vector<std::vector<double>> matriz_vacia(N, fila_vacia);
        M = matriz_vacia;

        for(int i = 0; i < N; i++){        
            double x,y;
            std::cin >> x >> y;
            posiciones[i] = std::make_pair(x,y);
        }
        
        for(int i = 0; i < N; i++){
            for(int j = i+1; j < N; j++){
                if(j != i){
                    double d = distancia(i,j);
                    M[i][j] = d;
                    M[j][i] = d;
                }
            }
        }
        
        inicializacion_union_find();
        std::vector<arista> AGM = kruskal();

        double costo_UTP = 0;
        double costo_fibra_optica = 0;
        
        for(auto &e : AGM){
            int u = e.u;
            int v = e.v;
            double peso = e.peso;       // <- si acá sumaras a distancia(u,v) estaria mal, porque en realidad las aristas que estás metiendo al AGM son entre componentes conexas, y u y v son los representantes, no los nodos.
            if(peso <= R && U <= V){
                costo_UTP = costo_UTP + U * peso;
            }else{
                costo_fibra_optica = costo_fibra_optica + V * peso;
            }
        }
        std::cout << "Caso #" << indice <<": " << std::fixed << std::setprecision(3) << costo_UTP << " " << costo_fibra_optica << std::endl;
        indice++;
    }
    return 0;
}

// 43 2 en oficina 6 y 98 de break