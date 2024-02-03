#include <iostream>
#include <vector>

int _n = -1; 
int _m = -1;
std::vector<std::vector<bool>> _visitas, _visitas_completable;
std::vector<int> _checkinValores;
std::vector<std::pair<int,int>> _checkinPosiciones(3,std::make_pair(0,0));
std::vector<std::pair<int,int>> _movimientos = {{1,0},{-1,0},{0,1},{0,-1}};


///@brief Determina si la posición (i,j) puede alcanzar a todos los checkpoints luego de haber dado cierta cantidad de pasos.
///@param i Fila en la que se encuentra el robot.
///@param j Columna en la que se encuentra el robot.
///@param steps Cantidad de pasos dadas. 
///@return Retorna true si son todos los checkpoints son alcanzables, false en caso contrario.
bool enRango(int i, int j,int steps){
    bool res = true;
    for(int k = 0; k < 4; k++){
        auto checkinValue = _checkinValores[k];
        auto checkinPosition = _checkinPosiciones[k];
        if(steps <= checkinValue) {
            res = res &&  (std::abs(i-checkinPosition.first) + std::abs(j-checkinPosition.second)) <= (checkinValue - steps);
        }
    }
    return res;
}

///@brief Itera sobre las cuatro celdas adyacentes a la posicion (i,j) para ver si se generaron particiones.
///@param i Fila en la que se encuentra el robot.
///@param j Columna en la que se encuentra el robot.
bool burbujas(int i, int j){
    if((i != 0  && i != _n-1) && (j != 0 && j != _m - 1)){
        if((_visitas[i][j - 1] && _visitas[i][j + 1]) &&(!_visitas[i-1][j] && !_visitas[i+1][j])){return true;}
        if((!_visitas[i][j - 1] && !_visitas[i][j + 1]) &&(_visitas[i-1][j] && _visitas[i+1][j])){return true;}
    }
    return false;
}

///@brief Determina si la posicion (i,j) se encuentra dentro del tablero.
///@param i Fila en la que se encuentra el robot.
///@param j Columna en la que se encuentra el robot.
bool fueraDelTablero(int i, int j){
    return i < 0 || j < 0 || i >= _n || j >= _m ;
}

///@brief Determina cuantas celdas son necesarias para completar el tablero, alcanzables desde la posicion (i,j). 
///@param i Fila en la que se encuentra el robot.
///@param j Columna en la que se encuentra el robot.
///@return Devuelve la cantidad de celdas alcanzables.
int celdasNecesarias(int i, int j){
    if(fueraDelTablero(i,j)){return 0;}                                                                                 
    if(_visitas[i][j] || _visitas_completable[i][j]){return 0;} 
    int sum = 1;
    _visitas_completable[i][j] = true;
    for(auto m: _movimientos){
        sum = sum + celdasNecesarias(i + m.first,j + m.second);
    }
    return sum;
}

///@brief Determina de cuantas formas se puede recorrer todo el tablero, pasando por los checkpoints con la cantidad de pasos adecuada de forma recursiva.
///@param i Fila en la que se encuentra el robot.
///@param j Columna en la que se encuentra el robot.
///@param steps Cantidad de pasos dados.
int RobotsOnIce(int i, int j,int steps){
    if(fueraDelTablero(i,j)){return 0;}                                                                                  
    if(_visitas[i][j]){return 0;}                                                                                         
    for(int h = 0; h < 4; h++){
        if(i == _checkinPosiciones[h].first && j == _checkinPosiciones[h].second && steps != _checkinValores[h]){return 0;} // Poda 1:  En la celda indicada en el momento equivocado.
    }
    if(!enRango(i,j,steps)){return 0;}                                                                                      // Poda 2: En rango.
    if(burbujas(i,j)){return 0;}                                                                                            // Poda 3: Generando particiones. 
    std::vector<bool> vacio(_m, false);
    _visitas_completable = std::vector<std::vector<bool>> (_n,vacio);
    _visitas_completable[i][j] = true;
    if(celdasNecesarias(0,1) != (_n * _m) - steps){return 0;}                                                               // Poda 4: Celdas restantes.
    if(steps == _checkinValores[3] && i == 0 && j == 1){return 1;}                                                          // Si el robot se encuentra en la posicion final con la cantidad adecuada de pasos, sumo 1.

    _visitas[i][j] = true; 
    int res = 0;
    for(auto m: _movimientos){
        res = res + RobotsOnIce(i + m.first,j + m.second,steps + 1);
    }
    _visitas[i][j] = false;                                                                                              
    return res;
}

///@brief Lee el standard input y hace las asignaciones necesarias en las estructuras de datos.
void leerCheckIns(){
    std::vector<int> v(6);
    for(int i = 0; i < 6; i++){
        std::cin >> v[i];
    }
    for(int j = 0; j < 3; j++){
        int a = v[2*j];
        int b = v[2*j+1];
        _checkinPosiciones[j] = std::make_pair(a,b);
    }
    _checkinPosiciones.push_back(std::make_pair(0,1));
    _checkinValores = {(_n*_m)/4,(_n*_m)/2,3*(_n*_m)/4,(_n*_m)};
}


int main(){
    int caseNumber = 1;
    while(_n != 0 && _m != 0){
        std::cin >> _n;                 
        std::cin >> _m;
        if(_n == 0 && _m == 0){break;}
        leerCheckIns();
        std::vector<bool> vacio(_m, false);
        _visitas = std::vector<std::vector<bool>> (_n,vacio);
        std::cout << "Case " << caseNumber << ": " << RobotsOnIce(0,0,1) << std::endl;
        caseNumber = caseNumber + 1;
    }
    return 0;
}
