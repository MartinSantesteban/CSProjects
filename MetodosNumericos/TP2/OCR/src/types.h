#pragma once

#include <Eigen/Sparse>
#include <Eigen/Dense>

using Eigen::MatrixXd;

typedef Eigen::Matrix<double, Eigen::Dynamic, Eigen::Dynamic, Eigen::RowMajor> Matrix;
typedef Eigen::VectorXd Vector;

typedef Eigen::SparseMatrix<double> SparseMatrix;