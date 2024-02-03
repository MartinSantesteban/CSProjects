#include <gtest/gtest.h>
#include "../types/matriz.h"
#include "../types/vector.h"
#include<vector>

TEST(Constructor, EmptyConstructor) {    
    Matriz A = Matriz();
    EXPECT_EQ(A.get_dimension(), Dimension(0, 0));
}

TEST(Constructor, DimensionConstructor) {    

    Matriz A(3, 3);
    EXPECT_EQ(A.get_dimension(), Dimension(3, 3));
    for (int i = 0; i < 3; ++i) {
        EXPECT_EQ(A[i], Vector({0, 0, 0}));
        for (int j = 0; j < 3; ++j)
            EXPECT_EQ(A[i][j], 0);
    }

    Matriz B(10, 5);
    EXPECT_EQ(B.get_dimension(), Dimension(10, 5));
    for (int i = 0; i < 10; ++i) {
        EXPECT_EQ(B[i], Vector({0, 0, 0, 0, 0}));
        for (int j = 0; j < 5; ++j)
            EXPECT_EQ(B[i][j], 0);
    }
}

TEST(Constructor, ArrayConstructor) {
    Vector* U = new Vector({1, 2, 3});
    Vector* V = new Vector({4, 5, 6});
    Vector* W = new Vector({7, 8, 9});
    Vector* M[3] = {
        U, V, W
    };

    Matriz A = Matriz(3, 3, &M[0]);
    EXPECT_EQ(A[0], Vector({1, 2, 3}));
    EXPECT_EQ(A[1], Vector({4, 5, 6}));
    EXPECT_EQ(A[2], Vector({7, 8, 9}));
}

TEST(Constructor, StandardVectorConstructor) {    
    Matriz A = Matriz({
        {1,5,6},
        {8,7,2},
        {3,9,4}  
    });
    EXPECT_EQ(A[0], Vector({1,5,6}));
    EXPECT_EQ(A[1], Vector({8,7,2}));
    EXPECT_EQ(A[2], Vector({3,9,4}));
}

TEST(Constructor, FunctionConstructor) {    
    Vector V({1,2,3});
    Matriz A(5, 5, [] (int i, int j) { return i + j; });
    Matriz B(3, 3, [V](int i, int j){ return V[j];  });
    EXPECT_EQ(A, 
    Matriz({
        {0, 1, 2, 3, 4},
        {1, 2, 3, 4, 5},
        {2, 3, 4, 5, 6},
        {3, 4, 5, 6, 7},
        {4, 5, 6, 7, 8}
    }));
    EXPECT_EQ(B, 
    Matriz({
        {1, 2, 3},
        {1, 2, 3},
        {1, 2, 3}
    }));
}

TEST(Constructor, CopyConstructor) {    
    Matriz A(5, 5, [](int i, int j){ return i+j; });
    Matriz B(A);
    EXPECT_EQ(A, B);
    B[2][2] = 8;
    EXPECT_NE(A, B);
    Matriz C = A;
    EXPECT_EQ(A, C);
    A[2] = {2,3,8,5,6};
    EXPECT_EQ(A, B);
    EXPECT_NE(A, C);
}

TEST(Equality, MatrixEquality){
    Matriz A = Matriz(5, 5);
    Matriz B = Matriz(3, 3);
    EXPECT_NE(A, B);
    A = B;
    EXPECT_EQ(A, B);
    A.set_tolerance(1.0e-10);
    EXPECT_EQ(A, B);
    A = B;
    EXPECT_EQ(A, B);
}

TEST(Equality, ElementEquality){
    Matriz A(5, 5, [](int i, int j){ return i+j; });
    Matriz B = A;
    
    EXPECT_EQ(A.get_dimension(), B.get_dimension());//dim
    EXPECT_EQ(A.get_tolerance(), B.get_tolerance());//tolerancia
    for(int i = 0; i < 5; ++i)
        for(int j = 0; j < 5; ++j)
            EXPECT_EQ(A[i][j], B[i][j]);            //Elementos
    A[0] = {2,7,8,1,3};
    for(int i = 0; i < 5; ++i)
        EXPECT_NE(A[0][i], B[0][i]);                //Desreferencia
    B = A;
    for(int i = 0; i < 5; ++i)
        EXPECT_EQ(A[0][i], B[0][i]);                //Ambos deberian ser 7
    B[1][1] = 5;
    EXPECT_NE(B[1][1], A[1][1]);
    A = B;
    EXPECT_EQ(B[1][1], A[1][1]);                    //Ambos deberian ser 5
}

TEST(Addition, Basic) {
    Matriz A(3, 3, [](int i, int j){ return  1; });
    Matriz B(3, 3, [](int i, int j){ return  i+j+1; });
    Matriz C(3, 3, [](int i, int j){ return ((i+1)+(j+1))%2; });
    Matriz D = A;
    D += B;
    EXPECT_EQ(D, Matriz({
        {2,3,4},
        {3,4,5},
        {4,5,6}
    }));
    EXPECT_EQ(D-A+C, Matriz({
        {1,3,3},
        {3,3,5},
        {3,5,5}
    }));
}

TEST(Addition, Associativity) {
    Matriz A(6, 6, [](int i, int j){ return  1; });
    Matriz B(6, 6, [](int i, int j){ return  1/(i+j+1); });
    Matriz C(6, 6, [](int i, int j){ return (i*71)%(j+1); });
    Matriz D(6, 6, [](int i, int j){ return i*i + j*j; });
    Matriz E(6, 6, [](int i, int j){ return i%3+j%3; });
    EXPECT_EQ((A+B)+C, A+(B+C));
    EXPECT_EQ((B+C)+D, B+(C+D));
    EXPECT_EQ((C+D)+E, C+(D+E));
}

TEST(Addition, Conmutativity) {
    Matriz A(6, 6, [](int i, int j){ return  1; });
    Matriz B(6, 6, [](int i, int j){ return  1/(i+j+1); });
    Matriz C(6, 6, [](int i, int j){ return (i*71)%(j+1); });
    Matriz D(6, 6, [](int i, int j){ return i*i + j*j; });
    Matriz E(6, 6, [](int i, int j){ return i%3+j%3; });
    EXPECT_EQ(A+B, B+A);
    EXPECT_EQ(B+C, C+B);
    EXPECT_EQ(C+D, D+C);
    EXPECT_EQ(D+E, E+D);
}

TEST(ScalarMultiplication, Conmutativity) {
    Matriz A(10, 10, [](int i, int j){ return 1 ; });
    Matriz B(10, 10, [](int i, int j){ return 5 ; });
    Matriz C(10, 10, [](int i, int j){ return 10; });
    EXPECT_EQ(A*10, C);
    EXPECT_EQ(10*A, C);
    EXPECT_EQ(A*10, 10*A);
    EXPECT_EQ(C/2, B);
    EXPECT_EQ(C/2, A*5);
    EXPECT_EQ(C*3/10, A*3);
}

TEST(VectorMultiplication, Identity) {
    Vector V({1,2,3,4,5});
    Matriz I = Matriz::I(5);
    EXPECT_EQ(I*V, V);
    EXPECT_EQ(2*I*V, Vector({2,4,6,8,10}));
}

TEST(VectorMultiplication, Elemental) {
    Vector V({1,2,3,4,5});
    Matriz P = Matriz::P(5, 3, 2);
    EXPECT_EQ(P*V, Vector({1,2,4,3,5}));
    P = Matriz::P(5, {2,1,3,0,4});
    EXPECT_EQ(P*V, Vector({3,2,4,1,5}));
}

TEST(MatrixMultiplication, Identity) {
    Matriz A(5, 5, [](int i, int j){ return 1; });
    Matriz B(25, 25, [](int i, int j){ return i+j+1; });
    Matriz C(100, 100, [](int i, int j){ return (i*j*i * (5/7) - j*j * (7/6) + i * (3/2) ); });
    EXPECT_EQ(A*Matriz::I(5), Matriz::I(5)*A);
    EXPECT_EQ(A*Matriz::I(5), Matriz::one(5, 5));
    EXPECT_EQ(Matriz::I(25)*B, Matriz::I(25)*B);
    EXPECT_EQ(Matriz::I(100)*C, Matriz::I(100)*C);
}

TEST(MatrixMultiplication, Basic) {
    Matriz A({{1,2,1,2},
              {6,3,1,3},
              {3,2,2,4},
              {1,2,4,1}});
    Matriz B({{3,5,2,1},
              {4,3,2,4},
              {2,3,2,3},
              {4,1,2,1}});
    Matriz C = A;
    C *= B;
    EXPECT_EQ(C, Matriz({
        {21,16,12,14},
        {44,45,26,24},
        {37,31,22,21},
        {23,24,16,22}
    }));
    EXPECT_EQ(B*A, Matriz({
        {40,27,16,30},
        {32,29,27,29},
        {29,23,21,24},
        {17,17,13,20}
    }));
}

TEST(MatrixMultiplication, Inverse) {
    Matriz A({{1,0,0,0},
              {2,1,0,0},
              {3,2,1,0},
              {4,3,2,1}});
    Matriz B({{1,0,0,0},
              {-2,1,0,0},
              {1,-2,1,0},
              {0,1,-2,1}});
    EXPECT_EQ(A*B, B*A);
}

TEST(Operations, Transpose) {
    Matriz A({{1,3,5,4},
              {2,1,2,3},
              {3,2,9,6},
              {4,8,7,1}});
    EXPECT_EQ(A.t(), Matriz({
        {1,2,3,4},
        {3,1,2,8},
        {5,2,9,7},
        {4,3,6,1}
    }));
    
    Matriz C(50, 50, [](int i, int j){return (j >= i) * (i+j+1);});
    Matriz D(50, 50, [](int i, int j){return (j <= i) * (i+j+1);});
    EXPECT_EQ(C.t(), D);
}

TEST(Operations, Trace) {
    Matriz A({{1,3,5,4},
              {2,1,2,3},
              {3,2,9,6},
              {4,8,7,1}});
    EXPECT_EQ(A.tr(), 12);
    EXPECT_EQ(A.tr(), A.t().tr());
    
    EXPECT_EQ((Matriz::I(50)*5).tr(), 5*50);
    EXPECT_EQ(Matriz::M(5, 1, 6).tr(), 5+5);
}

TEST(Elementals, Identity) {
    Matriz A({{1,0,0,0},
              {0,1,0,0},
              {0,0,1,0},
              {0,0,0,1}});
    EXPECT_EQ(A, Matriz::I(4));
    EXPECT_EQ(Matriz::I(4), Matriz::I(4).t());
    EXPECT_EQ(Matriz::I(10).tr(), 10);
    EXPECT_EQ(Matriz::I(5)*Matriz::I(5), Matriz::I(5));
    EXPECT_EQ(Matriz::I(7)-Matriz::I(7), Matriz::zero(7, 7));
}

TEST(Elementals, Canonical) {
    Matriz A({{0,0,0,0},
              {0,0,0,0},
              {0,0,1,0},
              {0,0,0,0}});
    EXPECT_EQ(A, Matriz::E(4, 4, 2, 2));
    EXPECT_EQ(Matriz::E(7, 7, 4, 2), Matriz::E(7, 7, 2, 4).t());
    Matriz B({{1,3,1,2},
              {2,5,4,3},
              {6,7,1,3},
              {3,2,6,2}});
    EXPECT_EQ(B*Matriz::E(4, 4, 1, 1), Matriz({
        {0,3,0,0},
        {0,5,0,0},
        {0,7,0,0},
        {0,2,0,0}
    }));
    EXPECT_EQ(Matriz::E(4, 4, 1, 1)*B, Matriz({
        {0,0,0,0},
        {2,5,4,3},
        {0,0,0,0},
        {0,0,0,0}
    }));
}

TEST(Elementals, Multiplication) {
    Matriz A({{1,0,0,0},
              {0,1,0,0},
              {0,0,8,0},
              {0,0,0,1}});
    EXPECT_EQ(A, Matriz::M(4, 2, 8));
    EXPECT_EQ(Matriz::M(8, 5, 6), Matriz::M(8, 5, 6).t());
    EXPECT_EQ((Matriz::M(5, 2, 2) * Matriz::one(5, 5) * Matriz::M(5, 2, 2))[2][2], 4);
    Matriz B({{1,4,2,9},
              {2,1,4,5},
              {3,4,8,6},
              {2,5,6,1}});
    EXPECT_EQ(Matriz::M(4, 2, 2)*B, Matriz({
        {1,4,2,9},
        {2,1,4,5},
        {6,8,16,12},
        {2,5,6,1}
    }));
    EXPECT_EQ(B*Matriz::M(4, 2, 2), Matriz({
        {1,4,4,9},
        {2,1,8,5},
        {3,4,16,6},
        {2,5,12,1}
    }));
}

TEST(Elementals, SimplePermutation) {
    Matriz A({{0,0,1,0},
              {0,1,0,0},
              {1,0,0,0},
              {0,0,0,1}});
    EXPECT_EQ(A, Matriz::P(4, 0, 2));
    EXPECT_EQ(Matriz::P(12, 2, 9), Matriz::P(12, 9, 2));
    EXPECT_EQ(Matriz::P(10, 4, 6)*Matriz::P(10, 4, 6), Matriz::I(10));
    Matriz B({{1,4,2,9},
              {2,1,4,5},
              {3,4,8,6},
              {2,5,6,1}});
    EXPECT_EQ(Matriz::P(4, 2, 3)*B, Matriz({
        {1,4,2,9},
        {2,1,4,5},
        {2,5,6,1},
        {3,4,8,6}
    }));
    EXPECT_EQ(B*Matriz::P(4, 2, 3), Matriz({
        {1,4,9,2},
        {2,1,5,4},
        {3,4,6,8},
        {2,5,1,6}
    }));
}

TEST(Elementals, ComplexPermutation) {
    Matriz A({{0,0,0,0,0,1,0},
              {0,1,0,0,0,0,0},
              {0,0,0,0,1,0,0},
              {0,0,1,0,0,0,0},
              {0,0,0,0,0,0,1},
              {1,0,0,0,0,0,0},
              {0,0,0,1,0,0,0}});
    EXPECT_EQ(A, Matriz::P(7, {5,1,4,2,6,0,3}));
    Matriz B({{1,4,2,9},
              {2,1,4,5},
              {3,4,8,6},
              {2,5,6,1}});
    EXPECT_EQ(Matriz::P(4, {2,0,3,1})*B, Matriz({
        {3,4,8,6},
        {1,4,2,9},
        {2,5,6,1},
        {2,1,4,5}
    }));
    EXPECT_EQ(B*Matriz::P(4, {2,0,3,1}), Matriz({
        {4,9,1,2},
        {1,5,2,4},
        {4,6,3,8},
        {5,1,2,6}
    }));
}

TEST(Elementals, Transformation) {
    Matriz A({{1,0,0,0},
              {0,1,0,0},
              {9,0,1,0},
              {0,0,0,1}});
    EXPECT_EQ(A, Matriz::T(4, 2, 0, 9));
    Matriz B({{4,2,7,1},
              {3,1,4,9},
              {7,9,3,2},
              {3,2,7,1}});
    EXPECT_EQ(Matriz::T(4, 2, 3, 3)*B, Matriz({
        {4,2,7,1},
        {3,1,4,9},
        {16,15,24,5},
        {3,2,7,1}
    }));
    EXPECT_EQ(B*Matriz::T(4, 2, 3, 3), Matriz({
        {4,2,7,22},
        {3,1,4,21},
        {7,9,3,11},
        {3,2,7,22}
    }));
}

TEST(Extend, Extend) {
    Matriz A({{4,2,7,1},
              {3,1,4,9},
              {7,9,3,2},
              {3,2,7,1}});
    Vector V({4, 3, 8, 2});
    EXPECT_EQ(A.extend(V), Matriz({
        {4,2,7,1,4},
        {3,1,4,9,3},
        {7,9,3,2,8},
        {3,2,7,1,2}
    }));
}