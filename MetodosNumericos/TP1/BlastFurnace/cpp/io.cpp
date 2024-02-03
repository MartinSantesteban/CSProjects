#include"io.h"

IO::IO(){ }

 void IO::read(const std::string& path, BlastFurnace& BF, std::vector<Vector>& T_is, std::vector<Vector>& T_es, int* ninst, double* iso) const {
    std::ifstream i;
    i.open(path);
    double r_i, R_e;
    int n, m;
    i >> r_i;
    i >> R_e;
    i >> m;
    i >> n;
    BF = *(new BlastFurnace(r_i, R_e, m, n));
    i >> (*iso);
    i >> (*ninst);
    for (int j = 0; j < *ninst; ++j) {
        T_is.emplace_back(Vector(n));
        T_es.emplace_back(Vector(n));
        for (int k = 0; k < n; ++k)
            i >> T_is[j][k];
        for (int k = 0; k < n; ++k)
            i >> T_es[j][k];
    }
    i.close();
    return;
}

int IO::write_temp(const std::string& path, int ninst, Matriz* O) const {
    std::ofstream o;
    o.open(path);
    for(int i = 0; i < ninst; ++i)
        for(int j = 0; j < O[i].get_dimension().m; ++j)
            for(int k = 0; k < O[i].get_dimension().n; ++k)
                o << std::fixed << std::setprecision(15) << O[i][j][k] << std::endl;
    o.close();
    return 1;
}

int IO::clear_time(const std::string& path) const {
    std::ofstream o;
    o.open(path);
    o.close();
    return 1;
}

int IO::write_time(const std::string& path, std::chrono::_V2::system_clock::duration duration) const {
    std::ofstream o;
    o.open(path, std::ios_base::app);
    o << duration.count() << std::endl;
    o.close();
    return 1;
}

int IO::write_iso(const std::string& path, int ninst, Vector* O) const {
    std::ofstream o;
    o.open(path);
    for(int i = 0; i < ninst; ++i)
        for(int j = 0; j < O[i].size(); ++j)
            o << std::fixed << std::setprecision(15) << O[i][j] << std::endl;
    o.close();
    return 1;
}