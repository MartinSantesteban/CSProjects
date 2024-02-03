#pragma once
#include "types.h"
#include "eigen.h"

class PCA {
public:
    PCA();
    PCA(unsigned int components);
    
    void fit(Matrix X);
    Matrix transform(const Matrix& X);
    unsigned int components();

private:
    unsigned int _n;
    Vector       _u;
    Vector       _eigenvalues;
    Matrix       _eigenvectors;
    unsigned int _components;
};
