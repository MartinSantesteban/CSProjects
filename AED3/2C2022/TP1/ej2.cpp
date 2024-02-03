#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>

/// @brief Encuentra los puntos en el eje horizontal tal que se intersectan la circunferencia con centro en (d, 0) y la recta horizontal a altura y.
/// @param d punto en que se centra la circunferencia en el eje x
/// @param r radio de la circunferencia
/// @param y altura a la que se busca la intersección
std::pair<float, float> interseccionConBorde(float d, float r, float y){
    if (r < y)
        return {-1, -1};
    std::pair<float, float> res = {d - sqrt(r*r - y*y), d + sqrt(r*r - y*y)};
    return res;
}


/// @brief dado un vector de aspersores (cada uno con su posición y radio), y dada la distancia hacia los extremos del terreno desde el centro de los mismos,
/// devuelve un par de enteros para cada aspersor indicando el rango del terreno que cubren completamente.
/// @param data vector con posición y radio de cada aspersor
/// @param w distancia entre el centro de los aspersores y los extremos del terreno
/// @param l longitud del terreno
/// @return vector de pares, donde el primer componente indica desde dónde cubre en el terreno y el segundo componente indica hasta dónde cubre. Si
std::vector<std::pair<float, float>> deCirculosARectangulos(std::vector<std::pair<float, float>> &data, float w, float l){
    std::vector<std::pair<float, float>> rectangulos;
    for (int i = 0; i < data.size(); i++){
        std::pair<float, float> temp = interseccionConBorde(data[i].first, data[i].second, w/2);
        if (temp.first == -1 && temp.second == -1)  //RE-ENTREGA: DESCARTAMOS LOS ASPERSORES QUE NO LLEGAN A CUBRIR NINGUN INTERVALO POR COMPLETO
            continue;
        temp.second = std::min(temp.second, l);
        temp.first = std::max(temp.first, (float)0);

        rectangulos.push_back(temp);
    }
    return rectangulos;
}


/// @brief Dada la secuencia de aspersores ordenada A, se busca un indice j > i tal que A[j] comienza a cubrir desde una posicion menor o igual a k y se extiende
/// lo mas a la derecha posible.
/// @param A secuencia ordenada de aspersores
/// @param k longitud ya cubierta
/// @param i ultimo aspersor utilizado. Este valor es modificado en caso de que la funcion retorne true
/// @return se retorna un booleano que indica si se encontro un aspersor que cumpla lo pedido y sea distinto a i. Si la respuesta es false se debe a que no se
/// puede utilizar ningun aspersor para seguir cubriendo el terreno.
/*bool usarElQueMasCubre(std::vector<std::pair<float, float>> &A, float k, int &i){   //RE-ENTREGA: CAMBIAMOS POR COMPLETO ESTA FUNCION, APROVECHANDO EL ORDEN DE LA SECUENCIA.
    int i_0 = i;
    int masCubre = i;
    int j = i+1;
    while(j < A.size() && A[j].first <= k){
        masCubre = (A[j].second > A[masCubre].second ? j : masCubre);
        j++;
    }
    i = masCubre;

    return i != i_0;
}
 */
bool usarElQueMasCubre(std::vector<std::pair<float, float>> &A, float k, int &i){   //RE-ENTREGA: CAMBIAMOS POR COMPLETO ESTA FUNCION, APROVECHANDO EL ORDEN DE LA SECUENCIA.
    int i_0 = i;
    int j = i+1;
    int masCubre = j;
    while(j < A.size() && A[j].first <= k){
        masCubre = (A[j].second > A[masCubre].second ? j : masCubre);
        j++;
    }
    if (j > i+1)
        i = masCubre;

    return i != i_0;
}


/// @brief dado un vector de pares tal que se indica para cada aspersor dónde empieza y dónde termina, queremos encontrar la mín. cantidad necesaria de los mismos
/// para cubrir el terreno.
/// @param A secuencia ordenada de aspersores descritos en funcion del intervalo que cubren.
/// @param k longitud ya cubierta del terreno.
/// @param l largo del terreno.
/// @param i ultimo aspersor utilizado de la secuencia
/// @returns se retorna un par (int, bool) donde el segundo valor indica si se pudo cubrir el terreno o no. En caso de ser falso, el primer valor es -1. En caso
/// de ser verdadero, el primer valor indica la mínima cantidad de aspersores necesaria.
std::pair<int, bool> wateringGrass(std::vector<std::pair<float, float>> &A, float k, float l, int &i){  //RE-ENTREGA: IMPLEMENTACION EN O(n*log(n))
    if (k == l)
        return {0, true};
    else{
        if (usarElQueMasCubre(A, k, i)){
            std::pair<int, bool> resto = wateringGrass(A, A[i].second, l, i);
            return (resto.second ? std::make_pair(1 + resto.first, resto.second) : std::make_pair(-1, resto.second));
        }else {
            return {-1, false};
        }
    }
}


/// @brief operador de comparacion para ordenar la secuencia de aspersores
bool compareDesdeHasta(const std::pair<float, float> &a, const std::pair<float, float> &b){
    return (a.first == b.first ? a.second < b.second : a.first < b.first);
}


/// @brief esta función resuelve el ejercicio 2 del TP1.
/// @param data vector de aspersores donde para cada uno se indica su posición y radio de operación.
/// @param l longitud del terreno.
/// @param w ancho del terreno.
/// @return cantidad mínima de aspersores necesaria para cubrir el terreno.
int ejercicio2(std::vector<std::pair<float, float>> &data, float l, float w){
    std::vector<std::pair<float, float>> rectangulos = deCirculosARectangulos(data, w, l);
    std::sort(rectangulos.begin(), rectangulos.end(), compareDesdeHasta);
    int i = -1;

    return wateringGrass(rectangulos, 0, l, i).first;
}


/// @brief Lee los casos de test con el formato especificado en el enunciado del TP1 y ejecuta para cada uno la función 'ejercicio2', imprimiendo el resultado.
void executeTest(){
    std::vector<std::pair<float, float>> data;
    int n;
    float l, w;
    while (std::cin >> n){
        std::cin >> l >> w;
        data.clear();
        for (int i = 0; i < n; i++){
            float dist, radio;
            std::cin >> dist >> radio;
            std::pair<float, float> info = std::make_pair(dist, radio);
            data.push_back(info);
        }
        int res = ejercicio2(data, l, w);
        std::cout << res << std::endl;
    }
}


int main() {
    executeTest();
    return 0;
}



