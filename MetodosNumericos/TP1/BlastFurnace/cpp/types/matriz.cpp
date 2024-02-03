#include"matriz.h"

Matriz::Matriz() : _dim({0, 0}), _values(new Vector*[0]) { }

Matriz::Matriz(int m, int n) : _dim({m, n}), _values(new Vector*[_dim.m]), _tolerance(TOLERANCE) {
    for(int i = 0; i < _dim.m; ++i)
        _values[i] = new Vector(_dim.n);
}

Matriz::Matriz(const Matriz& B) : Matriz() {
    *this = B;
}

Matriz::Matriz(const Vector& V) : Matriz(1, V.size()) {
    Vector* W = new Vector(V);
    _values[0] = W;
}

Matriz::Matriz(int m, int n, Vector** VS) : _dim({m, n}), _values(new Vector*[m]), _tolerance(TOLERANCE) {
    for(int i = 0; i < _dim.m; ++i)
        _values[i] = VS[i];
}

Matriz::Matriz(std::vector<std::vector<double>> VS) : _dim({int(VS.size()), int(VS[0].size())}), _values(new Vector*[_dim.m]), _tolerance(TOLERANCE) {
    for(int i = 0; i < _dim.m; ++i)
        _values[i] = new Vector(VS[i]);
}

Matriz::Matriz(int m, int n, std::function<double(int, int)> f) : _dim({m, n}), _values(new Vector*[_dim.m]), _tolerance(TOLERANCE) {
    for(int i = 0; i < m ; ++i)
        _values[i] = new Vector(_dim.n, [i, &f](int j){ return f(i, j);});
}


Matriz::~Matriz() {
    for(int i = 0; i < _dim.m; ++i)
        delete _values[i];
}

Matriz& Matriz::operator = (const Matriz& B) {
    for(int i = 0; i < _dim.m; ++i)
        delete _values[i];
    delete _values;
    _dim = B._dim;
    _values = new Vector*[_dim.m];
    for(int i = 0; i < B._dim.m; ++i)
        _values[i] = new Vector(B[i]);
    _tolerance = B._tolerance;
    return *this;
}

bool Matriz::operator == (const Matriz& B) const {
    if (_dim != B._dim)
        return false;
    for (int i = 0; i < _dim.m; ++i)
        for (int j = 0; j < _dim.n; ++j)
            if ( std::abs((*this)[i][j] - B[i][j]) > std::min(B.get_tolerance(), _tolerance) )
                return false;
    return true;
}

bool Matriz::operator != (const Matriz& B) const {
    return !((*this) == B);
}

Matriz& Matriz::operator += (const Matriz& B) {
    assert(_dim == B._dim);
    for(int i = 0; i < _dim.m; ++i)
        (*this)[i] += B[i];
    return *this;
}

Matriz Matriz::operator + (const Matriz& B) const {
    Matriz A = *this;
    A += B;
    return A;
}

Matriz& Matriz::operator -= (const Matriz& B) {
    assert(_dim == B._dim);
    for(int i = 0; i < _dim.m; ++i)
        (*this)[i] -= B[i];
    return *this;
}

Matriz Matriz::operator - (const Matriz& B) const {
    Matriz A = *this;
    A -= B;
    return A;
}

Matriz& Matriz::operator *= (double scalar) {
    for(int i = 0; i < _dim.m; ++i)
            (*this)[i] *= scalar;
    return *this;
}

Matriz Matriz::operator * (double scalar) const {
    Matriz A = (*this);
    A *= scalar;
    return A;
}

Matriz& Matriz::operator /= (double scalar) {
    assert(scalar != 0);
    for(int i = 0; i < _dim.m; ++i)
            (*this)[i] /= scalar;
    return *this;
}

Matriz Matriz::operator / (double scalar) const {
    Matriz W = (*this);
    W /= scalar;
    return W;
}

Matriz operator *  (const double scalar, const Matriz& B) {
    return B * scalar;
}

Matriz& Matriz::operator *= (const Matriz& B) {
    assert(_dim.n == B._dim.m);
    Matriz A = Matriz(_dim.m, B._dim.n);
    Matriz Bt = B.t();
    for(int i = 0; i < A._dim.m; ++i)
        for(int j = 0; j < A._dim.n; ++j)
            A[i][j] = (*this)[i] * Bt[j];
    *this = A;
    return *this;
}

Matriz  Matriz::operator * (const Matriz& B) const {
    Matriz A = (*this);
    A *= B;
    return A;
}

Vector Matriz::operator * (const Vector& V) const {
    assert(_dim.n == V.size());
    Vector W = Vector(_dim.m);
    for(int i = 0; i < _dim.m; ++i)
        for(int j = 0; j < W.size(); ++j)
            W[i] = (*this)[i] * V;
    return W;
}

Matriz Matriz::t() const {
    Matriz A = Matriz( {_dim.n, _dim.m} );
    for(int i = 0; i < _dim.m; ++i)
        for(int j = 0; j < _dim.n; ++j)
            A[j][i] = (*this)[i][j];
    return A;
}

double Matriz::tr() const {
    double tr = 0;
    for (int i = 0; i < std::min(_dim.m, _dim.n); ++i)
        tr += (*this)[i][i];
    return tr;
}

Vector& Matriz::operator [] (int i) const{
    assert( i >= 0 );
    assert( i < _dim.m );
    return *(_values[i]);
}

Dimension Matriz::get_dimension() const {
    return _dim;
}

void Matriz::set_tolerance(double tolerance) {
    _tolerance = tolerance;
}

double Matriz::get_tolerance() const {
    return _tolerance;
}

Matriz Matriz::extend(const Vector& b) const {
    assert(_dim.m == b.size());
    Matriz A(_dim.m, _dim.n + 1, [&](int i, int j){
        if (j == _dim.n)
            return b[i];
        else
            return (*this)[i][j];
    });
            
    return A;
}

void Matriz::apply(std::function<double(double)> f) {
    for(int i = 0; i < _dim.m; ++i)
        for(int j = 0; j < _dim.n; ++j)
            (*this)[i][j] = f((*this)[i][j]);
}

Matriz Matriz::t(const Vector& V) {
    return Matriz(V);
}

Matriz Matriz::zero(int m, int n) {
    Matriz A = Matriz(m, n, [](int i, int j){ return  0;});
    return A;
}

Matriz Matriz::one(int m, int n) {
    Matriz A = Matriz(m, n, [](int i, int j){ return  1;});
    return A;
}

Matriz Matriz::I(int n) {
    Matriz A = Matriz(n, n, [](int i, int j){ return i == j;});
    return A;
}

Matriz Matriz::E(int m, int n, int i, int j) {
    assert((i < m) && (j < m));
    Matriz A = Matriz::zero(m, m);
    A[i][j] = 1;
    return A;
}

Matriz Matriz::P(int n, int i, int j) {
    assert((i < n) && (j < n));
    Matriz A = Matriz::I(n);
    A[i][i] = A[j][j] = 0;
    A[i][j] = A[j][i] = 1;
    return A;
}

Matriz Matriz::P(int n, const Vector& p) {
    assert(p.size() >= n);
    Matriz A = Matriz::zero(n, n);
    for (int i = 0; i < n; ++i)
        A[i][p[i]] = 1;
    return A;
}

Matriz Matriz::P(int n, const std::vector<int>& p) {
    assert(p.size() >= n);
    Matriz A = Matriz::zero(n, n);
    for (int i = 0; i < n; ++i)
        A[i][p[i]] = 1;
    return A;
}

Matriz Matriz::M(int n, int i, int a) {
    assert(i < n);
    Matriz A = Matriz::I(n);
    A[i][i] *= a;
    return A;
}

Matriz Matriz::T(int n, int i, int j, int a) {
    assert((i < n) && (j < n));
    Matriz A = Matriz::I(n);
    A[i][j] += a;
    return A;
}

std::ostream& operator<< (std::ostream& os, const Matriz& M) {
    for (int i = 0; i < M._dim.m; i++)
        os << M[i];
    return os;
}