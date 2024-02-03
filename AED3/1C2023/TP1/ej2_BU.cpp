#include <iostream>
#include <vector>
#include <cmath>
#include <string>

int N;
int W;
int M;
int R;
int C;
std::vector<int> V;
std::vector<std::vector<int>> A; 

//-----------------------------------------------------
// FUNCIONES PARA DEBUGGEAR
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
    //Casos base
    for(int i = 0; i < M; i++){
        A[N][i] = false;
    }
    A[N][R] = true;
    for(int i = N - 1; i >= 0; i--){
        for(int j = 0; j < M; j++){
            //std::cout << i << ", " << j << std::endl;
            A[i][j] = (A[i+1][(j + V[i] + M) % M] ||A[i+1][(j * V[i] + M) % M]) || (A[i+1][(int) std::fmod(std::pow((double) j,(double) V[i]) + M,M)] || A[i+1][(j - V[i] + M) % M]);
        }
    }
    //print_matriz(A);
    return A[0][0]; //podria devolver (1,V[0]%M)
}

int main(){
    std::cin >> C;
    while(C > 0){
        std::cin >> N;
        std::cin >> R;
        std::cin >> M;
        V = std::vector(N, -1);      
        std::vector<int> vacio(M, -1);
        A = std::vector(N + 1, vacio);
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