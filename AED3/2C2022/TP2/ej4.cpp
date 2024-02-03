#include <iostream>
#include <vector>

//representa x_a - x_b <= c
struct ecuacion{
    int a;
    int b;
    int c;
};

/// @brief Primero se setean las variables como el máx elemento del conjunto D. Luego se hacen pasadas por las inecuaciones x_j <= x_i + c. Para aquellas que no se
///cumplan, buscamos el max. valor menor a x_j que haga que se cumpla la restricción. Si no realizamos ningún cambio se debe o bien a que se cumplen todas las
///inecuaciones, o bien a que para las que no se cumplen no hay forma de cambiar los valores para que se satisfagan.
/// @param D conjunto de valores posibles
/// @param var_index los índices que representan los valores que toma cada variable. Por ejemplo, si D[3] = 5 y var_index[1] = 3, significa que x_1 = 5
/// @param ecuaciones conjunto de ecuaciones a satisfacer
/// @return un booleano indicando si el sistema tiene solución o no.
bool fishburn(const std::vector<int> D, std::vector<int> &var_index, const std::vector<ecuacion> &ecuaciones){
    for (int i = 0; i < var_index.size(); i++)                               //inicializamos los índices con el del valor más grande en D
        var_index[i] = D.size()-1;

    bool changed;
    do {
        changed = false;
        for (auto ec : ecuaciones){                                          //recorremos las ecuaciones.
            if (D[var_index[ec.a]] > D[var_index[ec.b]] + ec.c){
                int indiceBueno = var_index[ec.a];
                    while (indiceBueno > 0 && D[indiceBueno] > D[var_index[ec.b]] + ec.c)
                        indiceBueno--;
                    if (indiceBueno < var_index[ec.a]){
                        var_index[ec.a] = indiceBueno;
                        changed = true;
                    }
            }
        }
    } while (changed);

    for (auto ec : ecuaciones){
        if (D[var_index[ec.a]] > D[var_index[ec.b]] + ec.c)
            return false;
    }
    return true;
}

/// @brief lee los test cases y ejecuta para cada uno la funcion 'fishburn', imprimiendo el resultado obtenido.
void executeTest(){
    int T, k, n, m;
    std::cin >> T;
    while (T > 0){
        std::cin >> k >> n >> m;
        if (m == 0){
            std::cout <<  "insatisfactible" << std::endl;
        } else {
            std::vector<ecuacion> ecuaciones(k);
            for (int i = 0; i < k; i++){
                int a, b, c;
                std::cin >> a >> b >> c;
                ecuacion eq = {a-1, b-1, c};
                ecuaciones[i] = eq;
            }

            std::vector<int> D(m);
            for (int i = 0; i < m; i++){
                int valor;
                std::cin >> valor;
                D[i] = valor;
            }

            std::vector<int> var_index(n);
            bool res = fishburn(D, var_index, ecuaciones);

            if (res){
                for (int i = 0; i < var_index.size(); i++)
                    std::cout << var_index[i] + 1 << " ";
                std::cout << std::endl;
            } else {
                std::cout << "insatisfactible" << std::endl;
            }
        }
        T--;
    }
}




int main() {
    executeTest();

    return 0;
}
