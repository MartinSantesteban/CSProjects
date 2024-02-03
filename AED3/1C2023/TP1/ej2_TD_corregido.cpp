#include <iostream>
#include <vector>
#include <cmath>

int N;
int M;
int R;
int C;
std::vector<int> V;
std::vector<std::vector<int>> A; 



//--------------------------------------------------
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
//--------------------------------------------------

bool operaciones(int i, int s){
    if(i == N) return (s == R);
    if(A[i][s] == -1){
        bool rec_sum =  operaciones(i + 1, (s + V[i] + M) % M); 
        bool rec_sub =  operaciones(i + 1, (s - V[i] + M) % M);
        bool rec_prod = operaciones(i + 1, (s * V[i] + M) % M);
        bool rec_pow =  operaciones(i + 1, (int) std::fmod(std::pow((double) s,(double) V[i]) + M,M));
        A[i][s] = (rec_sum || rec_prod) || (rec_pow || rec_sub);
    }
    return A[i][s];
}

int main(){
    std::cin >> C;
    while(C > 0){
        std::cin >> N;
        std::cin >> R;
        std::cin >> M;
        std::vector<int> V0(N, -1);                 
        std::vector<int> vacio(M, -1);
        std::vector<std::vector<int>> A0(N, vacio);  

        A = A0;   // para que funcione en onlinegdb
        V = V0;

        for(int i = 0; i < N ; i++){
            std::cin >> V[i];
        }

        if(operaciones(1,V[0]%M)) // Deberia llamarse con (1,V[0]%M), si llamas con (0,0) tiene en cuenta casos no validos y hace calculos de mas.
            std::cout << "Si";
        else
            std::cout << "No";
        std::cout << std::endl;
        C--;
    }
    return 0;
}
