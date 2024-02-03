#include "pca.h"

using namespace std;

PCA::PCA() : _components(0) { }
PCA::PCA(unsigned int components) : _components(components) { }

void PCA::fit(Matrix X) {
    _n = X.rows();
    _u = X.colwise().mean();
    auto U = Eigen::MatrixXd::Constant(_n, 1, 1.0) * (_u.transpose());
    X = X - U;
    Matrix Mx = (X.transpose() * X) / (_n - 1);
    auto P = get_first_eigenvalues(Mx, _components, VectorDelta, 1024, 1.0e-4).first;
    _eigenvalues  = P.first;
    _eigenvectors = P.second;
}

Matrix PCA::transform(const Matrix& X) {
  return ((X - Eigen::MatrixXd::Constant(X.rows(), 1, 1.0) * (_u.transpose())) / std::sqrt(_n-1)) * _eigenvectors;  
}

unsigned int PCA::components() {
  return _components;
}