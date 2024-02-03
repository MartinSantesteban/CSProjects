#define _GLIBCXX_DEBUG 1
#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>


struct aspersor {
    float pos;
    float radio;
    float costo;
};

struct aspersorInter {
    float desde;
    float hasta;
    float costo;
};

/// @brief Encuentra los puntos en el eje horizontal tal que se intersectan la circunferencia con centro en (d, 0) y la recta horizontal a altura y.
/// @param d punto en que se centra la circunferencia en el eje x
/// @param r radio de la circunferencia
/// @param y altura a la que se busca la intersección
std::pair<float, float> interseccionConBorde(float d, float r, float y){
    if (r < y)
        return std::make_pair(d, d);
    std::pair<float, float> res = {d - sqrt(r*r - y*y), d + sqrt(r*r - y*y)};
    return res;
}


/// @brief dado un vector de aspersores (cada uno con su posición y radio), y dada la distancia hacia los extremos del terreno desde el centro de los mismos,
/// devuelve una descripción para cada aspersor a partir del rango del terreno que cubren completamente.
/// @param data vector con aspersores descritos por su posición y radio
/// @param w distancia entre el centro de los aspersores y los extremos del terreno
/// @param l longitud del terreno
std::vector<aspersorInter> deCirculosARectangulos(std::vector<aspersor> &data, float w, float l){
    std::vector<aspersorInter> rectangulos;
    for (int i = 0; i < data.size(); i++){
        std::pair<float, float> temp = interseccionConBorde(data[i].pos, data[i].radio, w/2);
        if (temp.second > l)
            temp.second = l;
        if (temp.first < 0)
            temp.first = 0;
        aspersorInter inter = {temp.first, temp.second, data[i].costo};
        rectangulos.push_back(inter);
    }
    return rectangulos;
}


float costoMinimo(std::vector<float> &M, std::vector<aspersorInter> &A, int size, int i, float l){
    if (i == size-1){
        if (A[i].hasta >= l){
            float res = A[i].costo;
            M[i] = res;
        } else
            M[i] = -1;
        return M[i];
    }
    if (M[i] == -9){
        std::vector<float> candidatos;
        if (A[i].desde == A[i+1].desde) candidatos.push_back(costoMinimo(M, A, size, i+1, l));    //si puedo considerar sin el i-ésimo
        if (A[i].hasta >= l) candidatos.push_back(A[i].costo);                                              //si el i-ésimo cubre toodo

        for (int k = i+1; k < size; k++){
            float sig = costoMinimo(M, A, size, k, l);
            if (sig == -1) continue;
            if (A[i].hasta >= A[k].desde ){
                float agregoI = sig + A[i].costo;
                candidatos.push_back(agregoI);
            }
        }

        if (candidatos.size() > 0){
            float min = candidatos[0];
            for (auto x : candidatos){
                if (x < min)
                    min = x;
            }
            M[i] = min;
        } else {
            M[i] = -1;              //no se puede cubrir el intervalo
        }
    }
    return M[i];
}


bool compareDesde(const aspersorInter &a, const aspersorInter &b){
    return a.desde < b.desde;
}
bool compareHasta(const aspersorInter &a, const aspersorInter &b){
    return a.hasta < b.hasta;
}

float ejercicio3(std::vector<aspersor> &data, float w, float l){
    std::vector<aspersorInter> aspInter = deCirculosARectangulos(data, w, l);

    std::sort(aspInter.begin(), aspInter.end(), compareHasta);
    std::stable_sort(aspInter.begin(), aspInter.end(), compareDesde);

    int size = aspInter.size();
    std::vector<float> M(size, -9);
    float res = costoMinimo(M, aspInter, size, 0, l);
    return res;
}




/// @brief Lee los casos de test con el formato especificado en el enunciado del TP1 y ejecuta para cada uno la función 'ejercicio2', imprimiendo el resultado.
void executeTest(){
    std::vector<aspersor> data;
    int n;
    float l, w;
    while (std::cin >> n){
        std::cin >> l >> w;
        data.clear();
        for (int i = 0; i < n; i++){
            float dist, radio, costo;
            std::cin >> dist >> radio >> costo;
            aspersor asp;
            asp.pos = dist;
            asp.radio = radio;
            asp.costo = costo;
            data.push_back(asp);
        }
        float res = ejercicio3(data, w, l);
        std::cout << res << std::endl;
    }
}


int main() {
    executeTest();
    return 0;
}
