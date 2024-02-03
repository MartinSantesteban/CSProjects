#include <gtest/gtest.h>
#include "../types/vector.h"
#include<vector>

TEST(Memory, Constructor) {
    Vector U;
    EXPECT_EQ(U.size(), 0);
    U = Vector(5);
    U[0] = 5;
    U[1] = 7;
    U[2] = 2;
    U[3] = 1;
    U[4] = 4;
    Vector V({5,7,2,1,4});
    std::vector<double> L = {5, 7, 2, 1, 4};
    Vector W(L);
    EXPECT_EQ(U, V);
    EXPECT_EQ(U, W);
    EXPECT_EQ(V, W);
}

TEST(Memory, FunctionConstructor) {
    Vector U(10, [](int i){return 1+i;});
    EXPECT_EQ(U, Vector({1,2,3,4,5,6,7,8,9,10}));
    Vector V(10, [](int i){return (1+i)*(1+i);});
    EXPECT_EQ(V, Vector({1,4,9,16,25,36,49,64,81,100}));
    Vector W(10, [](int i){return i%3;});
    EXPECT_EQ(W, Vector({0,1,2,0,1,2,0,1,2,0}));
}

TEST(Memory, Inmutability) {
    Vector U({0, 0, 0, 0, 0});
    Vector V({5,7,2,1,4});
    Vector W = V;
    EXPECT_EQ(W.size(), 5);
    EXPECT_EQ(W[0], 5);
    EXPECT_EQ(W[1], 7);
    EXPECT_EQ(W[2], 2);
    EXPECT_EQ(W[3], 1);
    EXPECT_EQ(W[4], 4);
    Vector X = U + W;
    EXPECT_EQ(W.size(), 5);
    EXPECT_EQ(W[0], 5);
    EXPECT_EQ(W[1], 7);
    EXPECT_EQ(W[2], 2);
    EXPECT_EQ(W[3], 1);
    EXPECT_EQ(W[4], 4);
    Vector Y = V * W;
    EXPECT_EQ(W.size(), 5);
    EXPECT_EQ(W[0], 5);
    EXPECT_EQ(W[1], 7);
    EXPECT_EQ(W[2], 2);
    EXPECT_EQ(W[3], 1);
    EXPECT_EQ(W[4], 4);
    U[4] = 21;
    V[2] = 15;
    X[3] = 37;
    Y[1] = 98;
    EXPECT_EQ(W.size(), 5);
    EXPECT_EQ(W[0], 5);
    EXPECT_EQ(W[1], 7);
    EXPECT_EQ(W[2], 2);
    EXPECT_EQ(W[3], 1);
    EXPECT_EQ(W[4], 4);
}

TEST(Addition, Associativity) {
    Vector U({6,62,12,32,12});
    Vector V({1,25,23,4,52});
    Vector W({23,3,32,52,6});
    Vector X({13,52,2,27,81});
    Vector Y({12,71,58,91,63});
    Vector Z({91,50,7,97,53});
    EXPECT_EQ((U+V)+W, U+(V+W));
    EXPECT_EQ((X+Y)+Z, X+(Y+Z));
    EXPECT_EQ((U+W)+Y, U+(W+Y));
    EXPECT_EQ((V+X)+Z, V+(X+Z));
}

TEST(Addition, Conmutativity) {
    Vector U({6,62,12,32,12});
    Vector V({1,25,23,4,52});
    Vector W({23,3,32,52,6});
    Vector X({13,52,2,27,81});
    Vector Y({12,71,58,91,63});
    Vector Z({91,50,7,97,53});
    EXPECT_EQ(U+V, V+U);
    EXPECT_EQ(V+W, W+V);
    EXPECT_EQ(X+Y, Y+X);
    EXPECT_EQ(Y+Z, Z+Y);
    EXPECT_EQ(U+V+W, W+V+U);
    EXPECT_EQ(X+Y+Z, Z+Y+X);
}

TEST(ScalarMultiplication, Conmutativity) {
    Vector U({3,1,2,4,27});
    Vector V({13,21,32,65,17});
    Vector W({24,2,42,67,19});
    EXPECT_EQ(5 * U, U * 5);
    EXPECT_EQ(8 * 10 * V, V * 8 * 10);
    EXPECT_EQ(45 * W + 45 * W, W * 90);
    EXPECT_EQ(U / 5 , U * 0.2);
    EXPECT_EQ(V / 10, V * 0.1);
}

TEST(ScalarMultiplication, FloatingPoint) {
    Vector U({10,1,2,3,7});
    Vector V({1,5,13,7,9});
    EXPECT_EQ(U/3.0,  Vector({10.0/3, 1.0/3, 2.0/3, 3.0/3, 7.0/3}));
    EXPECT_EQ(V/13.0, Vector({1.0/13, 5.0/13, 13.0/13, 7.0/13, 9.0/13}));
}

TEST(VectorMultiplication, Conmutativity) {
    Vector U({1,1,1,1,1});
    Vector V({1,2,3,4,5});
    Vector W({2,3,4,5,6});
    EXPECT_EQ(U*V, V*U);
    EXPECT_EQ(U*W, W*U);
    EXPECT_EQ(V*W, W*V);
}

TEST(VectorMultiplication, Distributive) {
    Vector U({16,51,62,23,71});
    Vector V({61,345,123,64,91});
    Vector W({68,93,84,29,67});
    EXPECT_EQ(U*(5+8)*V, U*5*V+U*8*V);
    EXPECT_EQ((V+W)*(U+V), V*U+V*V+W*U+W*V);
    EXPECT_EQ((25*V+5*V+15*V), (25+5+15)*V);
}

TEST(VectorMultiplication, FloatingPoint) {
    Vector U({13.2  ,5.11   ,7.2    ,54.43   ,7.21});
    Vector V({6.1   ,34.5   ,1.23   ,6.4     ,9.16});
    Vector W({8.61  ,68.12  ,8.34   ,5.55    ,2.21});
    EXPECT_LE(std::abs(U*V - 680.0666)  , TOLERANCE);
    EXPECT_LE(std::abs(U*V - V*U)       , TOLERANCE);
    EXPECT_LE(std::abs(U*W - 839.8138)  , TOLERANCE);
    EXPECT_LE(std::abs(U*W - W*U)       , TOLERANCE);
    EXPECT_LE(std::abs(V*W - 2468.6828) , TOLERANCE);
    EXPECT_LE(std::abs(V*W - W*V)       , TOLERANCE);
}

TEST(VectorFunctions, Apply) {
    Vector U(10, [](int i){return 1+i;});
    Vector V(10, [](int i){return (1+i)*(1+i);});
    U.apply([](int v){return v*v;});
    EXPECT_EQ(U, V);
    U = Vector(10, [](int i){return 1+i;});
    Vector W(10, [](int i){return 2+i;});
    U.apply([](int v){return v+1;});
    EXPECT_EQ(U, W);
}