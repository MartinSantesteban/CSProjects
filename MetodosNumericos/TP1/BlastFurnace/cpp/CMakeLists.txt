cmake_minimum_required(VERSION 3.14)
project(BlastFurnace)

# GoogleTest requires at least C++11
set(CMAKE_CXX_STANDARD 11)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

set(CMAKE_CXX_FLAGS "-Wall -Wextra")
set(CMAKE_CXX_FLAGS_DEBUG "-g")
set(CMAKE_CXX_FLAGS_RELEASE "-O3")

include(FetchContent)
FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/609281088cfefc76f9d0ce82e1ff6c30cc3591e5.zip
)

FetchContent_MakeAvailable(googletest)

enable_testing()

add_library(
    vector_library
    types/vector.h
    types/vector.cpp
)

add_library(
    matrix_library
    types/dimension.h
    types/vector.h
    types/vector.cpp
    types/matriz.h
    types/matriz.cpp
)

add_library(
    solve_library
    types/dimension.h
    types/vector.h
    types/vector.cpp
    types/matriz.h
    types/matriz.cpp
    types/LU.h
    types/LU.cpp
    solver.h
    solver.cpp
)

add_library(
    blast_furnace_library
    types/dimension.h
    types/vector.h
    types/vector.cpp
    types/matriz.h
    types/matriz.cpp
    types/LU.h
    types/LU.cpp
    solver.h
    solver.cpp
    blast_furnace.h
    blast_furnace.cpp
)

add_library(
    main_library
    types/dimension.h
    types/vector.h
    types/vector.cpp
    types/matriz.h
    types/matriz.cpp
    types/LU.h
    types/LU.cpp
    solver.h
    solver.cpp
    io.h
    io.cpp
    blast_furnace.h
    blast_furnace.cpp
)

add_executable(
    temperatura
    temperatura.cpp
)

add_executable(
    isoterma
    isoterma.cpp
)

add_executable(
    vector_test
    tests/vector.cc
)

add_executable(
    matrix_test
    tests/matrix.cc
)

add_executable(
    GE_test
    tests/ge.cc
)

add_executable(
    LU_test
    tests/lu.cc
)

add_executable(
    blast_furnace_test
    tests/blast_furnace.cc
)

target_link_libraries(
    vector_test
    vector_library
    gtest_main
)

target_link_libraries(
    matrix_test
    matrix_library
    gtest_main
)

target_link_libraries(
    GE_test
    solve_library
    gtest_main
)

target_link_libraries(
    LU_test
    solve_library
    gtest_main
)

target_link_libraries(
    blast_furnace_test
    blast_furnace_library
    gtest_main
)

target_link_libraries(
    temperatura
    main_library
)

target_link_libraries(
    isoterma
    main_library
)

include(GoogleTest)
gtest_discover_tests(vector_test)
gtest_discover_tests(matrix_test)
gtest_discover_tests(GE_test)
gtest_discover_tests(LU_test)
gtest_discover_tests(blast_furnace_test)