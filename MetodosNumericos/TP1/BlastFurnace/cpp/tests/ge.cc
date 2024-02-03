#include <gtest/gtest.h>
#include "../solver.h"
#include<vector>

TEST(GETest, Integer_3x3){
    Matriz A = Matriz({
        {1, 2, 3,  4},
        {1, 4, 9, 16},
        {1, 8,27, 64},
        {1,16,81,256}
    }
    );
    Vector b({2, 10, 44, 190});
    Vector x = Solver::SolveGE(A, b);
    EXPECT_EQ(x, Vector({-1, 1, -1, 1}));
}

TEST(GETest, FloatingPoint_4x4){
    Matriz A = Matriz({
        {43.5, 11.2, 5.25, 3.23},
        {2.34, 67.53, 23.3, 7.21},
        {9.62, 24.2, 87.67, 18.65},
        {8.23, 6.2, 1.4, 110.54}
    }
    );
    Vector b({98.54, 23.45, 65.82, 24.81});
    Vector x = Solver::SolveGE(A, b);
    x.set_tolerance(1.0e-4);
    Vector S({2.1779, 0.103361, 0.472513, 0.0505116});
    S.set_tolerance(1.0e-4);
    EXPECT_EQ(x, S);
}