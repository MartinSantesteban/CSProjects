#include"blast_furnace.h"

BlastFurnace::BlastFurnace (double r_i, double R_e, int mplus, int n) :
    _m(mplus-1), _n(n), _r_i(r_i), _R_e(R_e), _delta_r((R_e - r_i) / _m), _delta_theta(2.0 * M_PI / n), _LU(NULL) {
    assert((_m > 0) && (n > 0));
    assert((r_i > 0) && (R_e > r_i));

    Matriz A(n*(_m+1), n*(_m+1));
    for (int i = 1; i < _m; ++i)
        for (int j = 0; j < n; ++j) {
            A[i*n+j][i*n+j-n]       = coef(i, j, i-1, j);
            A[i*n+j][i*n+(j+n-1)%n] = coef(i, j, i  ,(j+n-1)%n);
            A[i*n+j][i*n+j]         = coef(i, j, i  , j);
            A[i*n+j][i*n+(j+1)%n]   = coef(i, j, i  ,(j+1)%n);
            A[i*n+j][i*n+j+n]       = coef(i, j, i+1, j);
        }

    _b_i = Vector(n,[&, n](int i){
        return coef(1, i, 0, i);
    });

    _b_e = Vector(n, [&](int i) {
        return coef(_m-1, i, _m, i);
    });

    _system = Matriz(n*(_m-1),n*(_m-1),[&A, n](int i, int j){
        return A[i+n][j+n];
    });
}

double BlastFurnace::coef(int i, int j, int r_k, int theta_k) {
    assert((i > 0) && (i < _m));

    double r = _r_i + i * _delta_r;
    if (((i-1) == r_k) && (j == theta_k))
        return std::pow(r * _delta_theta, 2) * _delta_r * (r - _delta_r);
    if ((i == r_k) && ((j+_n-1)%_n == theta_k))
        return r * std::pow(_delta_r, 3);
    if ((i == r_k) && (j == theta_k))
        return r * _delta_r * (
            (-2 * std::pow(r * _delta_theta, 2)) +
            (r * _delta_r * std::pow(_delta_theta, 2)) +
            (-2 * std::pow(_delta_r, 2))
        );
    if ((i == r_k) && ((j+1)%_n == theta_k))
        return r * std::pow(_delta_r, 3);
    if (((i+1) == r_k) && (j == theta_k))
        return _delta_r * std::pow(_delta_theta, 2) * std::pow(r, 3);
    return 0.0;
}

extern "C" {


Vector BlastFurnace::isotherm(const Vector& T_i, const Vector& T_e, double target, Method M) {
    assert((T_i.size() == _n) && (T_e.size() == _n));
    Matriz A = solve_temperatures(T_i, T_e, M);
    int iso_theta;
    Vector x(_n);
    for (int angulo = 0; angulo < _n; ++angulo) {
        iso_theta = _m;
        for (int radio = _m-1; radio >= 0; --radio)
            if (std::abs(A[radio][angulo] - target) < std::abs(A[iso_theta][angulo] - target))
                iso_theta = radio;
        x[angulo] = _r_i + _delta_r * iso_theta;
    }
    return x;
}
}
Matriz BlastFurnace::solve_temperatures(const Vector& T_i, const Vector& T_e, Method M) {
    assert((T_i.size() == _n) && (T_e.size() == _n));
    Vector b(_n*(_m-1), [&](int i){
        if (i < _n)
            return -_b_i[i] * T_i[i];
        if (i >= _n*(_m-2))
            return -_b_e[i-_n*(_m-2)] * T_e[i-_n*(_m-2)];
        return 0.0;
    });
    Vector x(_n*(_m-1));
    switch (M) {
        case M_LU:
            if (_LU == NULL)
                _LU = Solver::FactorLU(_system);
            x = Solver::SolveLU(*_LU, b);
            break;
        default:
            x = Solver::SolveGE(_system, b);
            break;
    }

    x = (T_i.concatenate(x)).concatenate(T_e);
    Matriz A(_m+1, _n, [&](int i, int j) {
        return x[i*_n+j];
    });

    return A;
}

double BlastFurnace::delta_r() const {
    return _delta_r;
}

double BlastFurnace::delta_theta() const {
    return _delta_theta;
}
