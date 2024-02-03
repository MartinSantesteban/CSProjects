#include <iostream>
#include <vector>
#include <limits.h>

std::vector<int> W;
std::vector<int> P;
std::vector<int> Caps;
std::vector<std::vector<int>> M;
int N; 
int G;
int INF = INT_MAX;

void print_vector(std::vector<int> M){
    for(int i = 0; i < M.size(); i++){
        std::cout << M[i] << " ";
    }
    std::cout << std::endl;
}


int Rapsnack(int i, int c){
    if(c < 0) return (-INF);
    if(i == N) return 0;
    if(M[i][c] == -1){
        M[i][c] = std::max(Rapsnack(i + 1, c), Rapsnack(i + 1, c - W[i]) + P[i]);
    }
    return M[i][c];
    
}

int main(){
    int T;
    std::cin >> T;
    while(T > 0){
        std::cin >> N;
        W = std::vector<int>(N,-1);
        P = std::vector<int>(N,-1);
        for(int i = 0; i < N ; i++){
            std::cin >> P[i] >> W[i];
        }
        //print_vector(P);
        //print_vector(W);
        std::cin >> G;
        Caps = std::vector<int>(G,-1);
        int max_Ci;
        for(int i = 0; i < G; i++){
            std::cin >> Caps[i]; 
            if(max_Ci < Caps[i]) max_Ci = Caps[i];
        }
        std::vector<int> vacio(max_Ci + 1, -1);
        M = std::vector<std::vector<int>> (N, vacio);
        int r;
        int max = 0;
        for(int i = 0; i < G; i++){
            r =  Rapsnack(0,Caps[i]);
            max += r;
        }
        std::cout << max << std::endl;
        T--;
    }
    return 0;
}