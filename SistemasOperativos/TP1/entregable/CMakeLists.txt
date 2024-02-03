cmake_minimum_required(VERSION 3.16)
project(tp_sistemas)

set(CMAKE_CXX_STANDARD 17)

find_package(Threads)
add_executable(tp_sistemas
        jugar.cpp gameMaster.cpp config.h config.cpp IO.cpp gameMaster.h equipo.cpp equipo.h definiciones.h IO.h)

add_executable(tiempos_sistemas
        buscar.cpp gameMaster.cpp config.h config.cpp IO.cpp gameMaster.h equipo.cpp equipo.h definiciones.h IO.h)

target_link_libraries(tp_sistemas Threads::Threads)

