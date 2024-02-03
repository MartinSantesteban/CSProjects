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

struct DSU{        // Codigo proporcionado por la catedra.

    DSU(int n){
        padre = std::vector<int>(n+1);
        rank = padre;
        for(int v = 0; v < n; v++) padre[v] = v;
    }

    int find(int v){
        if(v == padre[v]) return v;
        return find(padre[v]);
    }

    void unite(int u, int v){
        u = find(u), v = find(v);
        if(u == v) return;
        if(rank[u] < rank[v]) std::swap(u,v);
        padre[v] = padre[u];
        rank[u] = std::max(rank[u],rank[v]+1);
    }

    std::vector<int> padre;
    std::vector<int> rank;
};


std::vector<arista> conjunto_aristas;
std::vector<std::pair<int, int>> posiciones;

// FUNCIONES PARA DEBUGGEAR 
//----------------------------------------

void print_arista(arista e){
    std::cout << e.u << " , " << e.v << " , " << e.peso;
}

void print_conjunto_aristas( std::vector<arista> A){
    for(int i = 0; i < A.size(); i++){
        std::cout << i << ") ";
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
    DSU dsu(N);
    int cantidad_componentes = N;
    for(arista &e : conjunto_aristas){
        int u = e.u;
        int v = e.v;
        if(dsu.find(u) != dsu.find(v)){         
            //union
            dsu.unite(u,v);
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
            double x,y;
            std::cin >> x >> y;
            posiciones[i] = std::make_pair(x,y);
        }
        
        for(int i = 0; i < N; i++){
            for(int j = i+1; j < N; j++){
                conjunto_aristas.push_back(generar_arista(i,j));
            }
        }
        
        std::vector<arista> AGM = kruskal();

        double costo_UTP = 0;
        double costo_fibra_optica = 0;
        //print_conjunto_aristas(AGM);
        for(auto &e : AGM){
            int u = e.u;
            int v = e.v;
            double peso = e.peso;
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