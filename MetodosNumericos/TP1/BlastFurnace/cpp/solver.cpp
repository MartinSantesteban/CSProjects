#include"solver.h"

void Solver::GE(Matriz& A){
    for(int i = 0; i < A.get_dimension().m; ++i) {
        double m;
        if (A[i][i] == 0) {
            for(int j = i+1; j < A.get_dimension().m; ++j)
                assert(A[j][i] == 0);
            m = 1;
        }
        else
            m = A[i][i];
        for(int j = i+1; j < A.get_dimension().m; ++j) {
            double m_i = A[j][i]/m;
            for(int k = i; k < A.get_dimension().n; ++k)
                A[j][k] -= m_i * A[i][k];
        }
    }
}

LU* Solver::FactorLU(const Matriz& A) {
    Matriz* L = new Matriz(Matriz::I(A.get_dimension().m));
    Matriz* U = new Matriz(A);

    for(int i = 0; i < U->get_dimension().m; ++i) {
        double m;
        if ((*U)[i][i] == 0) {
            for(int j = i+1; j < U->get_dimension().m; ++j)
                assert((*U)[j][i] == 0);
            m = 1;
        }
        else
            m = (*U)[i][i];

        for(int j = i+1; j < U->get_dimension().m; ++j) {
            double m_i = (*U)[j][i]/m;
            (*L)[j][i] = m_i;
            (*U)[j]   -= m_i * (*U)[i];
        }
    }
    LU* B = new LU(L, U);
    return B;
}

Vector Solver::SolveGE(const Matriz& A, const Vector& b) {
    assert(A.get_dimension().n == b.size());
    Matriz G = A.extend(b);
    GE(G);
    Vector x(b.size());
    for(int i = b.size() - 1; i >= 0; --i) {
        assert(G[i][i] != 0);
        x[i] = G[i][A.get_dimension().n];
        for(int j = G.get_dimension().n - 2; j > i; --j)
            x[i] -= x[j] * G[i][j];
        x[i] /= G[i][i];
    }
    return x;
}

Vector Solver::SolveLU(const LU& A, const Vector& b) {
    Vector y = SolveLowerTriangular(A, b);
    Vector x = SolveUpperTriangular(A, y);
    return x;
}

Vector Solver::SolveUpperTriangular(const LU& A, const Vector& b) {
    assert((A._U)->get_dimension().n == b.size());
    Matriz G = (*A._U).extend(b);
    Vector x(b.size());
    for(int i = b.size() - 1; i >= 0; --i) {
        assert(G[i][i] != 0);
        x[i] = G[i][G.get_dimension().n-1];
        for(int j = G.get_dimension().n-2; j > i; --j)
            x[i] -= x[j] * G[i][j];
        x[i] /= G[i][i];
    }
    return x;
}

Vector Solver::SolveLowerTriangular(const LU& A, const Vector& b) {
    assert((A._L)->get_dimension().n == b.size());
    Matriz G = (*A._L).extend(b);
    Vector x(b.size());
    for(int i = 0; i < b.size(); ++i) {
        assert(G[i][i] != 0);
        x[i] = G[i][G.get_dimension().n-1];
        for(int j = 0; j < i; ++j)
            x[i] -= x[j] * G[i][j];
        x[i] /= G[i][i];
    }
    return x;
}