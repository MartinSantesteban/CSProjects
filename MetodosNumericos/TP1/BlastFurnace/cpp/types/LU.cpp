#include"LU.h"

LU::LU(Matriz* L, Matriz* U) : _L(L), _U(U) { }

Matriz LU::lower() const {
    return Matriz(*_L);
}

Matriz LU::upper() const {
    return Matriz(*_U);
}

Matriz LU::matrix() const {
    return Matriz(_L->get_dimension().m, _U->get_dimension().n, [&](int i, int j){
        return ((i <= j) ? (*_U)[i][j] : (*_L)[i][j]);
    });
}
