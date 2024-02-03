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

    IO io;
    BlastFurnace BF;
    int ninst = 0;
    std::vector<Vector> T_is;
    std::vector<Vector> T_es;
    double iso = 0.0;
    io.read(argv[1], BF, T_is, T_es, &ninst, &iso);

    BlastFurnace::Method metodo;
    if (!strcmp(argv[3], "EG") || !strcmp(argv[3], "0"))
        metodo = BlastFurnace::M_EG;
    else
        metodo = BlastFurnace::M_LU;
    
    Vector* O = new Vector[ninst];
    for (int k = 0; k < ninst; ++k)
        O[k] = BF.isotherm(T_is[k], T_es[k], iso, metodo);

    io.write_iso(argv[2], ninst, O);

    return 0;
}
