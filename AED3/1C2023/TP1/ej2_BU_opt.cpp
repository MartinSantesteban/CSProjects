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
void print_vector(std::vector<bool> v){
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
    std::vector<bool> predecesor = std::vector(M, false);      //sucesor saca la informacion de predecesor
    std::vector<bool> sucesor = std::vector(M, false);

    //Casos base
    for(int i = 0; i < M; i++){
        predecesor[i] = false;
    }
    predecesor[R] = true;
    //print_vector(predecesor);
    for(int i = N - 1; i >= 0; i--){    
        for(int j = 0; j < M; j++){
            sucesor[j] = (predecesor[(j + V[i] + M) % M] || predecesor[((j * V[i]) + M) % M]) || (predecesor[(int) std::fmod(std::pow((double) j,(double) V[i]) + M,M)] || predecesor[(j - V[i] + M) % M]);
        }
        predecesor = sucesor;
        //std::cout << i << ", " << V[i] << std::endl;
        //print_vector(sucesor);
    }
    //print_vector(sucesor);
    return sucesor[0]; 
}

int main(){
    std::cin >> C;
    while(C > 0){
        std::cin >> N;
        std::cin >> R;
        std::cin >> M;
        V = std::vector(N, -1);

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