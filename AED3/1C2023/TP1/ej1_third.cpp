#include <iostream>
#include <vector>

int N;
int K;
std::vector<std::vector<int>> C;
std::vector<std::vector<int>> RES;
bool cuadrado_encontrado = false;
std::vector<bool> restantes;
int numero_magico;

int suma_diag_izq;
int suma_diag_der;
int suma_parcial_fila;
std::vector<int> sumas_parciales_columnas;


void print_cuadrado(std::vector<std::vector<int>> B){
    for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            std::cout << B[i][j] << " ";
        }
        std::cout << std::endl;
    }
}

void cuadradoMagico_k(int i, int j){
    if(cuadrado_encontrado) return;
    if(i == N){  //si llegue aca, el cuadrado ya es magico!
        //print_cuadrado(C);
        //std::cout << std::endl;
        if(K == 1){
            cuadrado_encontrado = true;
            RES = C;
        }else{
            K = K - 1;
        }
        return;
    }

    int in = i;
    int jn = j;
    if (j == N - 1){
            in++;
            jn = 0;
        }else{
            jn++;
    }

    int copia_suma_fila;

    for(int k = 1; k < restantes.size(); k++){
        copia_suma_fila = suma_parcial_fila;
        if(restantes[k] &&  ((j != N - 1 && i != N - 1 && suma_parcial_fila + k < numero_magico  && sumas_parciales_columnas[j] + k < numero_magico) ||
                             (j == N - 1 && i != N - 1 && suma_parcial_fila + k == numero_magico && sumas_parciales_columnas[j] + k < numero_magico) ||
                             (j != N - 1 && i == N - 1 && suma_parcial_fila + k < numero_magico  && sumas_parciales_columnas[j] + k == numero_magico) ||
                             (j == N - 1 && i == N - 1 && suma_parcial_fila + k == numero_magico && sumas_parciales_columnas[j] + k == numero_magico))
                        &&  ((i != j && j != N - 1 - i) ||
                             (i == j && i != N - 1 && suma_diag_izq + k < numero_magico && suma_diag_der < numero_magico) ||
                             (i == j && i == N - 1 && suma_diag_izq + k == numero_magico && suma_diag_der == numero_magico) ||
                             (i != N - 1 && j == N - 1 - i && suma_diag_izq < numero_magico && suma_diag_der + k < numero_magico) || 
                             (i == N - 1 && j == 0 && suma_diag_izq < numero_magico && suma_diag_der + k == numero_magico))
                        &&   ((i != N - 2 || j != N - 2) || (i == N - 2 && j == N - 2 && (N == 3 || k + C[i-1][j] + C[i][j-1] + C[i-1][j-1] == numero_magico)))
                        &&   ((i != N - 2 || j != N - 1) || (i == N - 2 && j == N - 1 && (N == 3 || k + C[i][0] + C[i-1][j] + C[i - 1][0]   == numero_magico)))
                        &&   ((i != N - 1 || j != N - 2) || (i == N - 1 && j == N - 2 && (N == 3 || k + C[i][j-1] + C[0][j-1] + C[0][j]     == numero_magico)))){
                             
            // do
            sumas_parciales_columnas[j] += k;
            suma_parcial_fila += k;
            if(jn == 0) suma_parcial_fila = 0;
            if(j == i) suma_diag_izq += k;
            if(j == N - 1 - i) suma_diag_der += k;
            C[i][j] = k;
            restantes[k] = false;
            

            cuadradoMagico_k(in,jn);

            // undo 
            sumas_parciales_columnas[j] -= k;
            suma_parcial_fila = copia_suma_fila;
            if(j == i) suma_diag_izq -= k;
            if(j == N - 1 - i) suma_diag_der -= k;
            restantes[k] = true;
            C[i][j] = 0;
        }
    }
    return;
}




int main(){
    //Tomamos los parametros
    std::cin >> N;
    std::cin >> K;

    // Contruimos las estructuras de datos.
    std::vector<int> vacio(N,0);
    std::vector<std::vector<int>> C0(N, vacio); 
    std::vector<bool> restantes0((N*N) + 1, true);
    std::vector<int> sumas0(N,0);
    
    sumas_parciales_columnas = sumas0;
    C = C0;
    restantes = restantes0;

    numero_magico = ((N*N*N) + N) / 2 ;

    suma_parcial_fila = 0;
    suma_diag_izq = 0;
    suma_diag_der = 0;

    cuadradoMagico_k(0,0);
    if(cuadrado_encontrado){
        print_cuadrado(RES);
    }else{
        std::cout << -1 << std::endl;
    }
    return 0;
}