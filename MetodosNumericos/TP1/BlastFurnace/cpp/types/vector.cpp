#include"vector.h"

Vector::Vector() : Vector(0) { }

Vector::Vector(int size) : _size(size), _values(new double[size]), _tolerance(TOLERANCE) {
    for (int i = 0; i < _size; ++i)
        _values[i] = 0;
}

Vector::Vector(int size, double* values) : _size(size), _values(new double[size]), _tolerance(TOLERANCE) {
    for (int i = 0; i < _size; ++i)
        _values[i] = values[i];
}

Vector::Vector(const Vector& V) : _size(V.size()), _values(new double[V.size()]), _tolerance(TOLERANCE) {
    for (int i = 0; i < _size; ++i)
        _values[i] = V._values[i];
}

Vector::Vector(const std::vector<double>& V) : _size(V.size()), _values(new double[V.size()]), _tolerance(TOLERANCE) {
    for (int i = 0; i < _size; ++i)
        _values[i] = V[i];
}

Vector::Vector(int size, std::function<double(int)> f) : _size(size), _values(new double[size]), _tolerance(TOLERANCE) {
    for(int i = 0; i < _size; ++i)
            _values[i] = f(i);
}

Vector::~Vector() {
     delete[] _values; 
}

Vector& Vector::operator = (const Vector& V) {
    delete _values;
    _size = V.size();
    _values = new double[_size];
    _tolerance = V.get_tolerance();
    for (int i = 0; i < _size; ++i)
        _values[i] = V[i];
    return *this;
}

Vector& Vector::operator = (const std::vector<double>& V) {
    delete _values;
    _size = V.size();
    _values = new double[_size];
    _tolerance = TOLERANCE;
    for (int i = 0; i < _size; ++i)
        _values[i] = V[i];
    return *this;
}

bool Vector::operator == (const Vector& V) const{
    if (_size != V.size()) return false;
    for (int i = 0; i < _size; ++i)
        if (std::abs(_values[i]-V[i]) > _tolerance)
            return false;
    return true;
}

bool Vector::operator != (const Vector& V) const{
    return !((*this) == V);
}

Vector& Vector::operator += (const Vector& V) {
    assert(_size == V.size());
    for (int i = 0; i < _size; ++i)
        _values[i] += V[i];
    return *this;
}

Vector Vector::operator + (const Vector& V) const {
    assert(_size == V.size());
    Vector W = *this;
    W += V;
    return W;
}

Vector& Vector::operator -= (const Vector& V) {
    assert(_size == V.size());
    for (int i = 0; i < _size; ++i)
        _values[i] -= V[i];
    return *this;
}

Vector Vector::operator - (const Vector& V) const {
    assert(_size == V.size());
    Vector W = *this;
    W -= V;
    return W;
}

Vector& Vector::operator *= (const double& scalar) {
    for (int i = 0; i < _size; ++i)
        _values[i] *= scalar;
    return *this;
}

Vector Vector::operator * (const double& scalar) const {
    Vector W = *this;
    W *= scalar;
    return W;
}

Vector  Vector::operator - () const {
    return (-1) * (*this);
}

Vector& Vector::operator /= (const double& scalar) {
    assert(scalar != 0);
    for (int i = 0; i < _size; ++i)
        _values[i] /= scalar;
    return *this;
}

Vector Vector::operator / (const double& scalar) const {
    assert(scalar != 0);
    Vector W = *this;
    W /= scalar;
    return W;
}

Vector operator * (const double& scalar, const Vector V) {
    return V * scalar;
}

double Vector::operator * (const Vector& V) const {
    assert(_size == V.size());
    double result = 0;
    double c = 0;
    for (int i = 0; i < _size; ++i) {
        double y = _values[i] * V[i] - c;
        double t = result + y;
        c = (t - result) - y;
        result = t;
    }
    return result;
}

double& Vector::operator [] (int i) const {
    assert(0 <= i && i < _size);
    return _values[i];
}

int Vector::size() const {
    return _size;
}

void Vector::set_tolerance(double tolerance) {
    _tolerance = tolerance;
}

double Vector::get_tolerance() const {
    return _tolerance;
}

void Vector::apply(std::function<double(double)> f) {
    for(int i = 0; i < _size; ++i)
            _values[i] = f(_values[i]);
}

Vector Vector::zero(int size) {
    Vector V = Vector(size, [](int i){ return 0;});
    return V;
}

Vector Vector::one(int size) {
    Vector V = Vector(size, [](int i){ return 1;});
    return V;
}

Vector Vector::reverse (const Vector& V) {
    Vector W = Vector(V.size(), [&V](int i){ return V[V.size() - (i+1)];});
    return W;
}

Vector Vector::concatenate (Vector V) const {
    Vector W (_size + V.size(), [&](int i) {
        return ((i < _size) ? (*this)[i] : V[i - _size]);
    });
    return W;
}

Vector Vector::subvector (int i, int j) const {
    assert(i >= 0 && i < _size);
    assert(j >= 0 && j <= _size);
    assert(i < j);
    Vector W (j-i, [&](int k) {
        return (*this)[k+i];
    });
    return W;
}

std::ostream& operator<< (std::ostream& os, const Vector& V) {
    os << '[';
    for (int i = 0; i < V.size(); i++)
        if (i < V.size() - 1)
            os << V[i] << ", ";
        else
            os << V[i] << "]\n";
    return os;
}
