#include <iostream>
#include <vector>
#include <cmath>

int N;
int M;
int R;
int C;
std::vector<int> V;

//-----------------------------------------------------
// FUNCIONES PARA DEBUGGEAR
void print_vector(std::vector<int> v){
    for(int i = 0; i < v.size();i++){
        std::cout << v[i];
    }
    std::cout << std::endl;
    return;
}

void print_matriz(std::vector<std::vector<int>> B){
    std::cout << std::endl;
    for(int i = 0; i < B.size(); i++){
        for(int j = 0; j < B[0].size(); j++){
            std::cout << B[i][j] << " ";
        }
        std::cout << std::endl;
    }
}
//-----------------------------------------------------

bool operaciones(){
    std::vector<bool> predecesor(M, false);     //declaración
    std::vector<bool> sucesor(M, false);        //declaración
    
    //Casos base
    for(int i = 0; i < M; i++){
        predecesor[i] = false;
    }
    predecesor[R] = true;
    int l;
    for(int i = N - 1; i >= 0; i--){
        l=0;
        for(int j = 0; j < M; j++){
            sucesor[j] = (predecesor[(j + V[i] + M) % M] || predecesor[(j * V[i] + M) % M]) || (predecesor[(int) std::fmod(std::pow((double) j,(double) V[i]) + M,M)] || predecesor[(j - V[i] + M) % M]);
            if(sucesor[j]) l++;
        }
        predecesor = sucesor; //optimizar
        if(l==M) return true;
    }
    return sucesor[0]; 
}

int main(){
    std::cin >> C;
    while(C > 0){
        std::cin >> N;
        std::cin >> R;
        std::cin >> M;

        std::vector<int> V0(N, -1);   //declaración  
        V = V0;

        for(int i = 0; i < N ; i++){
            std::cin >> V[i];
        }
        if(operaciones())
            std::cout << "Si";
        else
            std::cout << "No";
        std::cout << std::endl;
        C--;
    }
    return 0;
}
