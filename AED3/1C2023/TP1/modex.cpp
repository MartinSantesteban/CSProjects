#include <iostream>
#include <cmath>
#include <vector>
using namespace std;

// Completar
/*
int mod_bin_exp(int x, int y, int n) {
    int r = x % n; // x = r
    for(int i = 0; i < y - 1 ; i++){
        x = (x * r) % n; // r**2 % r
    }
    return x;
}
*/

 // [ ]

std::vector<int> vector_resto;
void print_vector(){
    std::cout << "Vector printeado : ";
    for(int i = 0 ; i < vector_resto.size() ; i++)
        std::cout << vector_resto[i] << " ";
    std::cout << std::endl;
}

int mod_bin_exp(int y, int i) {
    return vector_resto[y%i];
}

int vector_restos(int x, int n) {
    int r = (x%n); 
    int i = 1;
    while(x != 1){
        //std::cout << x << std::endl;
        x = (x * r) % n; // r**2 % r
        i++;
    }
    std::vector<int> vector_resto0(i, -1); 
    vector_resto0[0] = 1;
    for(int j = 1; j < i; j++){
        x = (x * r) % n; // r**2 % r
        vector_resto0[j] = x;
    }
    vector_resto = vector_resto0;
    return i;
}

int main() {
    int c; cin >> c;
    while (c--) {
        int x, y, n; cin >> x >> y >> n;
        int i = vector_restos(x,n);
        print_vector();
        cout << mod_bin_exp(y, i) << endl;
    }
    
    return 0;
}
