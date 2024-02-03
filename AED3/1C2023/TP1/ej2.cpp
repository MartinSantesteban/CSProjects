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

bool operaciones(int i, int s){
    if(i == N) return (s == R);
    bool rec_sum =  operaciones(i + 1, (s + V[i]) % M);
    bool rec_prod = operaciones(i + 1, (s * V[i]) % M);
    bool rec_pow =  operaciones(i + 1, ((int) std::pow(s,V[i])) % M);
    bool rec_sub =  operaciones(i + 1, (s - V[i]) % M);
    return (rec_sum || rec_prod || rec_pow || rec_sub);
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
        if(operaciones(1,V[0])) 
            std::cout << "Si";
        else
            std::cout << "No";
        std::cout << std::endl;
        C--;
    }
    
    return 0;
}