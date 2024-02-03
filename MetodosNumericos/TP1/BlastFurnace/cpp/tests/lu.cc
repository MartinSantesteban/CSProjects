#include <gtest/gtest.h>
#include "../solver.h"
#include<vector>

TEST(Memory, Inmutability) {
    Matriz A = Matriz::I(50);
    LU* B = Solver::FactorLU(A);
    A[0][0] = 5;
    EXPECT_NE(B->matrix()[0][0], 5.0);
}

TEST(LUTest, Identity) {
    Matriz I = Matriz::I(50);
    LU* B = Solver::FactorLU(I);
    EXPECT_EQ(B->matrix(), Solver::FactorLU(I)->matrix());
    EXPECT_EQ(B->upper(), I);
    EXPECT_EQ(B->lower(), I);
}

TEST(LUTest,Diagonal){
    Matriz Dm = Matriz({
        { 5, 0, 0, 0},
        { 0, 6, 0, 0},
        { 0, 0, 8, 0},
        { 0, 0, 0, 5}
    });
    Matriz L = Matriz({
        {1,0,0,0},
        {0,1,0,0},
        {0,0,1,0},
        {0,0,0,1}
    });
    Matriz U = Dm;
    LU* D = Solver::FactorLU(Dm);
    EXPECT_EQ(D->lower(),L);
    EXPECT_EQ(D->upper(),U);
    EXPECT_EQ(D->lower() * D->upper(), Dm);
}

//PRIMERO HACEMOS TESTS SUPONIENDO QUE NUNCA a_ii=0 o ld
TEST(LUTest, Integer_3x3_1){
    Matriz Am = Matriz({
        {1,2,3},
        {2,1,2},
        {0,3,5} //Hay infinitas LU, pero nuestro algo da la asociada a m.
    }
    );
    Matriz L = Matriz({
        {1, 0, 0},
        {2, 1, 0},
        {0,-1, 1}
    });
    Matriz U = Matriz({
        {1, 2, 3},
        {0,-3,-4},
        {0, 0, 1}
    });
    LU* A = Solver::FactorLU(Am);
    EXPECT_EQ(A->lower(), L);
    EXPECT_EQ(A->upper(), U);
    EXPECT_EQ(A->lower() * A->upper(), Am);
}

TEST(LUTest, Integer_3x3_2){
    Matriz Am = Matriz({
        {9,2,5},
        {81,28,47},
        {0,-10,2} //Hay infinitas LU, pero nuestro algo da la asociada a m.
    }
    );
    Matriz L = Matriz({
        {1, 0, 0},
        {9, 1, 0},
        {0,-1, 1}
    });
    Matriz U = Matriz({
        {9, 2, 5},
        {0,10, 2},
        {0, 0, 4}
    });
    LU* A = Solver::FactorLU(Am);
    EXPECT_EQ(A->lower(),L);
    EXPECT_EQ(A->upper(),U);
    EXPECT_EQ(A->lower() * A->upper(), Am);
    }

TEST(LUTest, Integer_4x4){
    Matriz Am = Matriz({
        { 2, 1,-1, 3},
        {-2, 0, 0, 0},
        { 4, 1,-2, 4},
        {-6,-1, 2,-3}
    });

    Matriz U = Matriz({
        {2, 1, -1, 3},
        {0, 1, -1, 3},
        {0, 0, -1, 1},
        {0, 0,  0, 1}
    });
    Matriz L = Matriz({
        { 1, 0, 0, 0},
        {-1, 1, 0, 0},
        { 2,-1, 1, 0},
        {-3, 2,-1, 1}
    });
    LU* A = Solver::FactorLU(Am);
    EXPECT_EQ(A->lower(),L);
    EXPECT_EQ(A->upper(),U);
    EXPECT_EQ(A->lower() * A->upper(), Am);
}

TEST(LUTest, FloatingPoint_4x4){
    Matriz Am = Matriz({
        { 2, 7, 1, 2},
        { 3,-5, 1, 0},
        { 0, 5, 7, 1},
        { 2, 3, 2, 8}
    });
    Matriz U = Matriz({
        {2, 7, 1, 2},
        {0, -31.0/2, -1.0/2, -3.0},
        {0, 0, 212.0/31, 1.0/31},
        {0, 0,  0, 1435.0/212}
    });
    Matriz L = Matriz({
        { 1, 0, 0, 0},
        {3.0/2, 1, 0, 0},
        {0, -10.0/31, 1, 0},
        {1, 8.0/31, 35.0/212, 1},
    });
    LU* A = Solver::FactorLU(Am);
    EXPECT_EQ(A->lower(), L);
    EXPECT_EQ(A->upper(), U);
    EXPECT_EQ(A->lower() * A->upper(), Am);
}