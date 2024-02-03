#include<iostream>
#include<iomanip>
#include<fstream>
#include<time.h>
#include<vector>

#include"CargarArchivos.hpp"
#include"HashMapConcurrente.hpp"

const unsigned int NS_PER_SECOND = 1000000000;
const unsigned int MAX_LETTERS = 26;
const unsigned int CANTIDAD_THREADS = 16;

const unsigned int N_ADDED_FILES = 10;
const char LETTER_LIST[] = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
const int LETTER_LIST_SIZE = 1;

unsigned int t_threads = 16; //correr para 16 y 8

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

int main(int argc, char* argv[]){
    if(argc != 5){
        std::cout << "modo de uso: <|buckets inicial|> <input_dir> <output_dir> <#samples>" << std::endl;
        return -1;
    }

    // Inicializamos todas las variables para output y medicion de tiempos.
    timespec t0, tf, delta;
    std::ofstream o;
    std::string output_path = std::string(argv[3]) + '/' + "unbalanced_measures";
    o.open(output_path);
    std::string folder = std::string(argv[2]) + "/unbalanced_letter";
    o << "sample,letra,size,threads,time" << std::endl;
    std::string clave_actual;
    for(int sample = 0; sample < atoi(argv[4]); sample++){
        for(int l = 0; l < LETTER_LIST_SIZE; l++){
            HashMapConcurrente hm;
            //Cargo el Hm base
            for(int i = 0; i < (int)MAX_LETTERS; i++){
                std::string letter_path = "../input/synthetic_unbalanced/";
                letter_path += LETTER_LIST[i];         
                std::ifstream file;
                file.open(letter_path,std::ios_base::app);
                int num_clave_actual = 0;
                while(file >> clave_actual && num_clave_actual < atoi(argv[1])){ 
                    hm.cargar_par(make_pair(clave_actual,1));
                    num_clave_actual++;
                }
            file.close();
            }
            
            //Cargo los archivos
            for(unsigned int i = 0; i <=  N_ADDED_FILES  ; i++){
                if(i != 0){  
                    std::string file_path = folder + '/' + LETTER_LIST[l] + '_' + std::to_string(i); 
                    std::ifstream file;
                    file.open(file_path);
                    while(!file.eof()){
                        file >> clave_actual;
                        hm.cargar_par(make_pair(clave_actual,1));
                    }
                    file.close();
                    std::cout << "Sample: " << (sample+1) << " de " << atoi(argv[4]) <<" .Archivo: " << LETTER_LIST[l] << '_' << i << " cargado." << std::endl;
                }
                for(unsigned int t = 1; t <= t_threads; t = t * t_threads){ 
                    clock_gettime(CLOCK_REALTIME, &t0);
                    hm.maximoParalelo(t);
                    clock_gettime(CLOCK_REALTIME, &tf);
                    sub_timespec(t0,tf,&delta);
                    o << (sample) <<','<< LETTER_LIST[l] << ',' << i << ',' << t  << ',' << delta.tv_sec << '.' << std::setfill('0') << std::setw(9) << delta.tv_nsec << std::endl;
                }
            }
        }
    }
    o.close();
    std::cout << "Fin del experimento." << std::endl;
    return 0;
}

