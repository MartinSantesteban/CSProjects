//
// Created by pachi on 5/6/19.
//

#include <iostream>
#include "structure/graph.hpp"
#include "structure/proximity_graph.hpp"
#include "pca.h"
#include "knn.h"
#include "eigen.h"

int main(int argc, char** argv){
  Eigen::Matrix<double,2,2> X;
  X << 2, 0,
       0, 1;
  std::cout << X << std::endl;
  Vector u = (Vector::Random(X.cols())).normalized();
  Vector v = u;
  double eps = 1e-32;
  double residuo_final;
  int iteraciones = 0;
  double eigenvalue;
  // (X * v - eigenvalue * v).norm() > eps  (u - v).norm() > eps
  do{
        u = v;
        v = (X * v).normalized();
        eigenvalue = (double)((v.transpose() * X) * v) / (v.norm() * v.norm());
        residuo_final = (u - v).norm();
        iteraciones++;
  }while((X * v - eigenvalue * v).norm() > eps);
  std::cout << "aca" << std::endl;
  std::cout << "Epsilon: " << eps << std::endl;
  std::cout << "Cantidad de iteraciones: " << iteraciones << std::endl;
  std::cout << "Residuo final: " << residuo_final << std::endl;
  std::cout << "Eigenvalue: " << eigenvalue << std::endl;
  return 0;
  
}