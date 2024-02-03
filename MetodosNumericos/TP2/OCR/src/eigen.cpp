#include <algorithm>
#include <chrono>
#include <iostream>
#include <cmath>
#include "eigen.h"

using namespace std;

double euclidean_distance(const Vector& A, const Vector& B) {
    return (A-B).norm();
}

pair<pair<double, Vector>,int> power_iteration(const Matrix& X, StopCriterion criterion, unsigned max_iter, double eps) {
    srand((unsigned int) time(0));
    Vector u = (Vector::Random(X.cols())).normalized();
    Vector v = u;
    double eigenvalue;

    std::function<bool()> guardian;
    switch (criterion) {
            case Iteration:{
                guardian = [&](){return true;};
            }
            case VectorDelta:{
                guardian = [&](){return (u - v).norm() > eps;};
            }
            case IsEigenValue:{
                guardian = [&](){return (X * v - eigenvalue * v).norm() > eps;};
            }
            default:{
                guardian = [&](){return true;};
            }
        }
    size_t iter = 0;
    do {
        u = v;
        v = (X * v).normalized();
        eigenvalue = (double)((v.transpose() * X) * v) / (v.norm() * v.norm());
    }while (guardian() && iter++ < max_iter);
    
    return make_pair(make_pair(eigenvalue, v),iter); //devuelve la cantidad de iteraciones para experimentación
}

std::pair<std::pair<Vector, Matrix>,int> get_first_eigenvalues(const Matrix& X, unsigned num, StopCriterion criterion, unsigned num_iter, double epsilon) {
    assert(num <= X.rows());
    Matrix A(X);
    Vector eigvalues(num);
    Matrix eigvectors(A.rows(), num);
    int total_iterations;
    for(size_t i = 0; i < num; ++i) {
        auto p = power_iteration(A, criterion, num_iter, epsilon);
        eigvalues(i) = (p.first).first;
        eigvectors.col(i) = (p.first).second;
        A -= (p.first).first* (p.first).second * (p.first).second.transpose();
        total_iterations = total_iterations + p.second;
    }
    return make_pair(make_pair(eigvalues, eigvectors),total_iterations);
}


