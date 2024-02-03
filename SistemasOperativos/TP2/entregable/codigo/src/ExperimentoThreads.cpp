#include<iostream>
#include<fstream>
#include<time.h>
#include<vector>

#include"CargarArchivos.hpp"
#include"HashMapConcurrente.hpp"

const unsigned int NS_PER_SECOND = 1000000000;
const unsigned int MAX_THREADS = 16;
const unsigned int SAMPLES = 10;

void sub_timespec(struct timespec t0, struct timespec tf, struct timespec *td) {
    td->tv_sec  = tf.tv_sec - t0.tv_sec;
    td->tv_nsec = tf.tv_nsec - t0.tv_nsec;
    if (td->tv_sec > 0 && td->tv_nsec < 0) {
        td->tv_nsec += NS_PER_SECOND;
        td->tv_sec--;
    }
    else if (td->tv_sec < 0 && td->tv_nsec > 0) {
        td->tv_nsec -= NS_PER_SECOND;
        td->tv_sec++;
    }
}

int main(int argc, char* argv[]) {

    if (argc != 4) {
        std::cout << "modo de uso: <cant archivos> <input dir> <output>" << std::endl;
        exit(0);
    }
    std::vector<std::string> filepaths;
    for (int i = 0; i < atoi(argv[1]); ++i)
        filepaths.emplace_back(std::string(argv[2]) + "/part_" + std::to_string(i));
    

    std::ofstream o;
    o.open(argv[3]);
    o << "threads, cargar, maximo" << std::endl;

    timespec t0, tf, delta;
    for (size_t n = 1; n <= MAX_THREADS; ++n) {
        for (size_t j = 1; j <= SAMPLES; ++j) {
            o << n << ", ";
            std::cout << n << ": " << j << '/' << SAMPLES << std::endl;
            HashMapConcurrente Hm;
            clock_gettime(CLOCK_REALTIME, &t0);
            cargarMultiplesArchivos(Hm, n, filepaths);
            clock_gettime(CLOCK_REALTIME, &tf);
            sub_timespec(t0, tf, &delta);
            o << delta.tv_sec << '.' <<  delta.tv_nsec << ", ";

            clock_gettime(CLOCK_REALTIME, &t0);
            Hm.maximoParalelo(n);
            clock_gettime(CLOCK_REALTIME, &tf);
            sub_timespec(t0, tf, &delta);
            o << delta.tv_sec << '.' <<  delta.tv_nsec << std::endl;
        }
    }
    o.close();

    return 0;
}