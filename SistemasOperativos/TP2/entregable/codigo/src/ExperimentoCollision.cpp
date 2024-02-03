#include<iostream>
#include <iomanip>
#include<fstream>
#include<time.h>
#include<vector>

#include"CargarArchivos.hpp"
#include"HashMapConcurrente.hpp"

const unsigned int NS_PER_SECOND = 1000000000;
const unsigned int MAX_THREADS = 16;
const unsigned int MAX_BUCKETS = 26;
const unsigned int SAMPLES = 32;

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
        std::cout << "modo de uso: <threads> <input> <output>" << std::endl;
        exit(0);
    }

    int n = atoi(argv[1]);
    timespec t0, tf, delta;
    std::vector<std::string> filepaths;
    std::ofstream o;

    o.open(std::string(argv[3]) + "_" + std::to_string(n) + ".csv");
    o << "threads,tiempo" << std::endl;

    for (char i = 'a'; i <= 'a'+n-1; ++i)
        filepaths.emplace_back(std::string(argv[2]) + '/' + i);

    for (size_t i = 1; i <= SAMPLES; ++i) {
        HashMapConcurrente Hm;
        std::cout << '(' << n << ')' << ": " << i << '/' << SAMPLES << std::endl;
        clock_gettime(CLOCK_REALTIME, &t0);
        cargarMultiplesArchivos(Hm, n, filepaths);
        clock_gettime(CLOCK_REALTIME, &tf);
        sub_timespec(t0, tf, &delta);
        o << n << ',' << delta.tv_sec << '.' << std::setfill('0') << std::setw(9) << delta.tv_nsec << std::endl;
    }
    o.close();

    return 0;
}