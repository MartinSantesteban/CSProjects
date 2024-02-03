#pragma once
#include <iostream>
#include <string>
#include <fstream>
#include "definiciones.h"

using namespace std;

class IO {
    private:
        ofstream output_stream;
    public:
        void open(string path);
        void write(double t, int n);
        void write(int n);
        void write(coordenadas);
        void write(coordenadas c, coordenadas d, string s);
        void write(string s, string t);
        void close();
};