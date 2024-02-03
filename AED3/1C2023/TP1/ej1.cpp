#include <iostream>
#include <vector>

int N;
int K;
std::vector<std::vector<int>> C;
std::vector<std::vector<int>> RES;
bool cuadrado_encontrado = false;
std::vector<bool> restantes;
int numero_magico;

bool esMagico(){
    bool res = true;
    for(int i = 0; i < N ; i++){
        int suma_fila = 0;
        int suma_columna = 0;
        for(int j = 0; j < N ; j++){
            suma_fila    += C[i][j];
            suma_columna += C[j][i];
        }
        res = ((res && (suma_fila == numero_magico)) && suma_columna == numero_magico);
    }
    int suma_diag1 = 0;
    int suma_diag2 = 0;
    for(int i = 0; i < N ; i++){
        suma_diag1 = suma_diag1 + C[i][i];
        suma_diag2 = suma_diag2 + C[i][N-i-1];        
    }
    return ((res && suma_diag1 == numero_magico) && suma_diag2 == numero_magico);
}



int sumaParcialFila(int i, int j){
    int res = 0;
    for(int k = 0; k < j; k++){
        res += C[i][k];
    }
    return res;
}

int sumaParcialColumna(int i, int j){
    int res = 0;
    for(int k = 0; k < i; k++){
        res += C[k][j];
    }
    return res;
}

int sumaParcialDiagonalIzq(int i, int j){
    int res = 0;
    for(int k = 0; k < i; k++){
        res += C[k][k];
    }
    if(j >= i) res += C[i][i];
    return res;
}
 
int sumaParcialDiagonalDer(int i, int j){
    int res = 0;
    for(int k = 0; k < i; k++){
        res += C[k][N - 1 - k];
    }
    if(j >= N - 1 - i) res += C[i][N - 1 - i];
    return res;
}

void print_cuadrado(std::vector<std::vector<int>> B){
    for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            std::cout << B[i][j] << " ";
        }
        std::cout << std::endl;
    }
    std::cout << std::endl;
}


void cuadradoMagico_k(int i, int j){
    //std::cout << i << ", " << j << std::endl;
    if(cuadrado_encontrado) return;
    if(i == N){
        if(esMagico()){
            if(K == 1){
                cuadrado_encontrado = true;
                RES = C;
            }else{
                K = K - 1;
            }
        }
        return;
    }
    
    int in = i;
    int jn = j;
    if (j == N - 1){
            in = i + 1;
            jn = 0;
        }else{
            jn = j + 1;
    }
    
    for(int k = 1; k < restantes.size(); k++){
        // Podas!
        int suma_parcial_fila = sumaParcialFila(i,j);
        int suma_parcial_columna = sumaParcialColumna(i,j);
        int suma_parcial_diagonal_izq = sumaParcialDiagonalIzq(i,j);
        int suma_parcial_diagonal_der = sumaParcialDiagonalDer(i,j);
        if(restantes[k] &&  ((j != N - 1 && suma_parcial_fila + k <= numero_magico && suma_parcial_columna + k <= numero_magico) ||
                            (j == N - 1 && suma_parcial_fila + k == numero_magico && suma_parcial_columna + k <= numero_magico) ||
                            (i == N - 1 && suma_parcial_fila + k <= numero_magico && suma_parcial_columna + k == numero_magico))
                            && (suma_parcial_diagonal_izq <= numero_magico && suma_parcial_diagonal_der <= numero_magico)){
            C[i][j] = k;
            restantes[k] = false;
        

            cuadradoMagico_k(in,jn);

            //rollback
            restantes[k] = true;
            C[i][j] = 0;
        }
    }
}




int main(){
    //Tomamos los parametros
    std::cin >> N;
    std::cin >> K;

    // Contruimos las estructuras de datos.
    std::vector<int> vacio = std::vector(N,0);
    C = std::vector(N, vacio);
    numero_magico = ((N*N*N) + N) / 2 ; 
    restantes = std::vector((N*N) + 1, true);

    cuadradoMagico_k(0,0);
    if(cuadrado_encontrado){
        print_cuadrado(RES);
    }else{
        std::cout << -1 << std::endl;
    }
    return 0;
}