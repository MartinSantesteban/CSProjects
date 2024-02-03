#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>
#include <iomanip>

int C;
int N;
int R;
int W;
int U;
int V;

struct arista{
    int u; 
    int v;
    double peso;
};

std::vector<arista> conjunto_aristas;
std::vector<std::pair<int, int>> posiciones;


// FUNCIONES PARA DEBUGGEAR 
//----------------------------------------

void print_arista(arista e){
    std::cout << "( " << e.u << " , " << e.v << " , " << e.peso << " )";
}

void print_conjunto_aristas( std::vector<arista> A){
    for(int i = 0; i < A.size(); i++){
        std::cout << std::endl;
        print_arista(A[i]); 
        std::cout << std::endl;
    }
}

//----------------------------------------

double distancia(int u,int v){             
    int u_x = posiciones[u].first;
    int u_y = posiciones[u].second;
    int v_x = posiciones[v].first;
    int v_y = posiciones[v].second;
    
    double a = (std::abs(u_x - v_x));
    double b = (std::abs(u_y - v_y));

    return std::sqrt((a * a) + (b * b));
}


arista generar_arista(int i,int j){
    arista res;
    res.u = i;
    res.v = j;
    res.peso = distancia(i,j);
    return res;
}

bool comparador_aristas(arista a, arista b){
    return a.peso < b.peso;
}


std::vector<arista> kruskal(){
    std::sort(conjunto_aristas.begin(), conjunto_aristas.end(), comparador_aristas);

    std::vector<arista> res;
    std::vector<int> representantes(N, -1);
    int cantidad_componentes = N;

    for(int i = 0; i < N; i++) representantes[i] = i;

    for(arista &e : conjunto_aristas){
        int u = e.u;
        int v = e.v;
        int peso = e.peso;
        if(representantes[u] != representantes[v]){         
            //union
            int representante_ganador = std::max(representantes[u],representantes[v]);
            int representante_perdedor = std::min(representantes[u],representantes[v]);
            for(int i = 0; i < N; i++){
                if(representantes[i] == representante_perdedor){
                    representantes[i] = representante_ganador;
                }
            }
            res.push_back(e);
            cantidad_componentes--;
            if(cantidad_componentes == W) break;
            
        } 
    }

    return res;
}

int main(){
    std::cin >> C;
    int indice = 1;
    while(indice <= C){
        std::cin >> N >> R >> W >> U >> V;

        std::vector<std::pair<int,int>> posiciones_vacias(N,std::make_pair(-1,-1));
        posiciones = posiciones_vacias;

        std::vector<arista> null_vector;
        conjunto_aristas = null_vector;

        for(int i = 0; i < N; i++){        
            int x,y;
            std::cin >> x >> y;
            posiciones[i] = std::make_pair(x,y);
        }
        
        for(int i = 0; i < N; i++){
            for(int j = i; j < N; j++){
                if(i != j)
                    conjunto_aristas.push_back(generar_arista(i,j));
            }
        }
        
        std::vector<arista> AGM = kruskal();

        double costo_UTP = 0;
        double costo_fibra_optica = 0;

        for(auto &e : AGM){
            int u = e.u;
            int v = e.v;
            int peso = e.peso;
            double d = distancia(u,v);
            if(d <= R && U <= V){
                costo_UTP = costo_UTP + U * d;
            }else{
                costo_fibra_optica = costo_fibra_optica + V * d;
            }
        }
        std::cout << "Caso #" << indice <<": " << std::fixed << std::setprecision(3) << costo_UTP << " " << costo_fibra_optica << std::endl;
        indice++;
    }
    return 0;
}