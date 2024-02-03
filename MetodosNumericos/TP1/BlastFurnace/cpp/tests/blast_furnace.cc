#include <gtest/gtest.h>
#include "../blast_furnace.h"
#include<vector>

TEST(Basic, Deltas) {
    BlastFurnace BF(40, 60, 11, 10);
    EXPECT_EQ(BF.delta_r(), 2);
    EXPECT_EQ(BF.delta_theta(), 2 * M_PI / 10);
}

TEST(Basic, Homogenous) {
    BlastFurnace BF(10, 20, 6, 5);
    Vector T_i(5, [](int i){return 10;});
    Vector T_e(5, [](int i){return 10;});
    EXPECT_EQ(BF.solve_temperatures(T_i, T_e, BlastFurnace::M_EG), 10 * Matriz::one(6, 5));
}

TEST(Catedra, Test1) {
    BlastFurnace BF(10, 100, 30, 30);
    Vector T_i(30, [](int i){return 1500;});
    Vector T_e(30, [](int i){return 0;});
    std::vector<double> V =
             {1500.00000, 1310.001656, 1165.002921, 1047.769900, 949.377901, 864.609409, 790.150599, 723.765635,
              663.874853, 609.3208730, 559.2304010, 512.9282840, 469.881784, 429.663157, 391.923760, 356.375682,
              322.778414, 290.9289810, 260.6545200, 231.8066040, 204.256844, 177.893437, 152.618428, 128.345512,
              104.998258, 82.50865800, 60.81593400, 39.86554600, 19.6083700, 0.000000};
    Matriz result = BF.solve_temperatures(T_i, T_e, BlastFurnace::M_EG);
    Matriz expected(30, 30, [&V](int i, int j) {return V[i];});
    for (int i = 0; i < 30; ++i)
        EXPECT_EQ(result[i], expected[i]);
    result = BF.solve_temperatures(T_i, T_e, BlastFurnace::M_LU);
    for (int i = 0; i < 30; ++i)
        EXPECT_EQ(result[i], expected[i]);
}

TEST(Catedra, Test2) {
    BlastFurnace BF(10, 100, 30, 30);
    Vector T_i(30, [](int i){return 1500;});
    Vector T_e(30, [](int i){return 1500;});
    Matriz result = BF.solve_temperatures(T_i, T_e, BlastFurnace::M_EG);
    Matriz expected(30, 30, [](int i, int j) {return 1500;});
    for (int i = 0; i < 30; ++i)
        EXPECT_EQ(result[i], expected[i]);
    result = BF.solve_temperatures(T_i, T_e, BlastFurnace::M_LU);
    for (int i = 0; i < 30; ++i)
        EXPECT_EQ(result[i], expected[i]);
}

TEST(Catedra, Test3) {
    BlastFurnace BF(1, 2, 30, 10);
    Vector T_i(10, [](int i){return 1500;});
    Vector T_e(10, [](int i){return 0;});
    std::vector<double> V = 
             {1500.000000, 1426.302323, 1355.061235, 1286.118247, 1219.329727, 1154.565102, 1091.705319,
              1030.641529, 971.2739560, 913.5109120, 857.2679480, 802.4671110, 749.0362960, 696.9086700,
              646.0221790, 596.3190950, 547.7456260, 500.2515670, 453.7899880, 408.3169540, 363.7912740,
              320.1742810, 277.4296290, 235.5231070, 194.4224790, 154.0973350, 114.5189530, 75.66017800,
              37.49530900, 0.000000000};
    Matriz result = BF.solve_temperatures(T_i, T_e, BlastFurnace::M_EG);
    Matriz expected(30, 10, [&V](int i, int j) {return V[i];});
    for (int i = 0; i < 30; ++i)
        EXPECT_EQ(result[i], expected[i]);
    result = BF.solve_temperatures(T_i, T_e, BlastFurnace::M_LU);
    for (int i = 0; i < 30; ++i)
        EXPECT_EQ(result[i], expected[i]);
}

TEST(Catedra, Test4) {
    BlastFurnace BF(10, 100, 30, 30);
    Vector T_i(30, [](int i){return 1500;});
    Vector T_e(30, [](int i){return 0;});
    std::vector<double> V = 
             {1500.00000, 1310.001656, 1165.002921, 1047.769900, 949.377901, 864.609409, 790.150599, 723.765635,
              663.874853, 609.3208730, 559.2304010, 512.9282840, 469.881784, 429.663157, 391.923760, 356.375682,
              322.778414, 290.9289810, 260.6545200, 231.8066040, 204.256844, 177.893437, 152.618428, 128.345512,
              104.998258, 82.50865800, 60.81593400, 39.86554600, 19.6083700, 0.000000};
    Matriz result = BF.solve_temperatures(T_i, T_e, BlastFurnace::M_EG);
    Matriz expected(30, 30, [&V](int i, int j) {return V[i];});
    for (int i = 0; i < 30; ++i)
        EXPECT_EQ(result[i], expected[i]);
    T_e = Vector(30, [](int i){return 1500;});
    result = BF.solve_temperatures(T_i, T_e, BlastFurnace::M_EG);
    expected = Matriz(30, 30, [&V](int i, int j) {return 1500;});
    for (int i = 0; i < 30; ++i)
        EXPECT_EQ(result[i], expected[i]);
    result = BF.solve_temperatures(T_i, T_e, BlastFurnace::M_LU);
    for (int i = 0; i < 30; ++i)
        EXPECT_EQ(result[i], expected[i]);
    T_e = Vector(30, [](int i){return 1500;});
    result = BF.solve_temperatures(T_i, T_e, BlastFurnace::M_LU);
    expected = Matriz(30, 30, [&V](int i, int j) {return 1500;});
    for (int i = 0; i < 30; ++i)
        EXPECT_EQ(result[i], expected[i]);
}