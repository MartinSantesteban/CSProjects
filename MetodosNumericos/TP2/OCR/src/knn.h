#pragma once

#include <algorithm>
#include <queue>

#include "types.h"
#include "pca.h"
#include "eigen.h"

class KNNClassifier {
public:
    KNNClassifier(unsigned int neighbours);

    void fit(const Eigen::VectorXi& labels, const Matrix& X, PCA transform);
    void raw(const Eigen::VectorXi& labels, const Matrix& X);

    Eigen::VectorXi predict(const Matrix& X,float pr = 0, Vector recall = Eigen::VectorXd::Constant(10, 0));

private:
    unsigned int    _neighbours; 
    Matrix          _samples;
    Eigen::VectorXi _labels;
    PCA             _pca;
};
