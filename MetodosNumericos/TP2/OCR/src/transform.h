#pragma once

#include <iostream>
#include "types.h"
#include "eigen.h"
 
using namespace std;
 
class Transform {
   public:
      Matrix transform(const Matrix& X) { 
         cout << "base transform" << endl;
         return X; 
      };
};