#include "IO.h"

void IO::open(string path) {
    output_stream = ofstream(path);
}

void IO::write(int n){
    output_stream << n << endl;
}

void IO::write(coordenadas c){
    output_stream << c.first << "," << c.second << endl; 
}

void IO::write(double t, int n){
    output_stream.precision(10);
    output_stream << fixed << t << "," << n << endl; 
}

void IO::write(coordenadas c, coordenadas d, string s){
    output_stream << c.first << "," << c.second << "," << d.first << "," << d.second << "," << s << endl; 
}

void IO::write(string s, string t){
    output_stream << s << "," << t << endl; 
}

void IO::close(){
    output_stream.close();
}

