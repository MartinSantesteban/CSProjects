#include<cassert>

#include <chrono>
#include <thread>

#include<iostream>
#include<fstream>
#include<string.h>
#include<vector>

#include"blast_furnace.h"
#include"io.h"

int main(int argc, char* argv[]) {

    if (argc != 4 || (strcmp(argv[3], "EG") && strcmp(argv[3], "LU") && strcmp(argv[3], "0") && strcmp(argv[3], "1"))) {
        std::cout << "modo de uso: <input> <output> <metodo = {EG, LU}>\n";
        exit(0);
    }

    std::string string_metodo;
    if (!strcmp(argv[3], "0"))
        string_metodo = "EG";
    else if (!strcmp(argv[3], "1"))
        string_metodo = "LU";
    else
        string_metodo = argv[3];

    IO io;
    size_t pos = ((std::string)argv[2]).find_last_of(".");
    std::string time_path = ((std::string)argv[2]).substr(0, pos) + "_" + string_metodo + ".time";
    BlastFurnace BF;
    int ninst = 0;
    std::vector<Vector> T_is;
    std::vector<Vector> T_es;
    double iso = 0.0;
    io.read(argv[1], BF, T_is, T_es, &ninst, &iso);

    BlastFurnace::Method metodo;
    if (string_metodo == "EG")
        metodo = BlastFurnace::M_EG;
    else
        metodo = BlastFurnace::M_LU;
    
    Matriz* O = new Matriz[ninst];

    auto start = std::chrono::high_resolution_clock::now();
    auto end   = std::chrono::high_resolution_clock::now();
    for (int k = 0; k < ninst; ++k) {
        start = std::chrono::high_resolution_clock::now();
        O[k]  = BF.solve_temperatures(T_is[k], T_es[k], metodo);
        end   = std::chrono::high_resolution_clock::now();
        auto nano_int = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start);
        io.write_time(time_path, nano_int);
    }
    
    io.write_temp(argv[2], ninst, O);

    return 0;
}
