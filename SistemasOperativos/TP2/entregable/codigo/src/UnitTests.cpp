#include <vector>
#include <map>
#include <set>
#include <thread>
#include <algorithm>
#include "lib/littletest.hpp"

#include "../src/ListaAtomica.hpp"
#include "../src/HashMapConcurrente.hpp"
#include "../src/CargarArchivos.hpp"

// Tests Ejercicio 1

LT_BEGIN_SUITE(TestsEjercicio1)

ListaAtomica<int> l;

void set_up()
{
}

void tear_down()
{
}
LT_END_SUITE(TestsEjercicio1)

LT_BEGIN_TEST(TestsEjercicio1, ListaComienzaVacia)
    LT_CHECK_EQ(l.longitud(), 0);
LT_END_TEST(ListaComienzaVacia)

LT_BEGIN_TEST(TestsEjercicio1, InsertarAgregaElemento)
    l.insertar(42);
    LT_CHECK_EQ(l.longitud(), 1);
LT_END_TEST(InsertarAgregaElemento)

LT_BEGIN_TEST(TestsEjercicio1, InsertarAgregaElementoCorrecto)
    l.insertar(42);
    LT_CHECK_EQ(l[0], 42);
LT_END_TEST(InsertarAgregaElementoCorrecto)

LT_BEGIN_TEST(TestsEjercicio1, InsertarAgregaEnOrden)
    l.insertar(4);
    l.insertar(3);
    l.insertar(2);
    l.insertar(1);
    LT_CHECK_EQ(l.longitud(), 4);
    LT_CHECK_EQ(l[0], 1);
    LT_CHECK_EQ(l[1], 2);
    LT_CHECK_EQ(l[2], 3);
    LT_CHECK_EQ(l[3], 4);
LT_END_TEST(InsertarAgregaEnOrden)

// Tests Ejercicio 2

LT_BEGIN_SUITE(TestsEjercicio2)

HashMapConcurrente hM;

void set_up()
{
}

void tear_down()
{
}
LT_END_SUITE(TestsEjercicio2)

LT_BEGIN_TEST(TestsEjercicio2, ValorEsCorrectoEnHashMapVacio)
    LT_CHECK_EQ(hM.valor("tiranosaurio"), 0);
LT_END_TEST(ValorEsCorrectoEnHashMapVacio)

LT_BEGIN_TEST(TestsEjercicio2, ClavesEsCorrectoEnHashMapVacio)
    std::vector<std::string> actual = hM.claves();
    std::vector<std::string> expected = {};
    LT_CHECK_COLLECTIONS_EQ(actual.begin(), actual.end(), expected.begin());
LT_END_TEST(ClavesEsCorrectoEnHashMapVacio)

LT_BEGIN_TEST(TestsEjercicio2, ValorEsCorrectoTrasUnaInsercion)
    hM.incrementar("tiranosaurio");
    LT_CHECK_EQ(hM.valor("tiranosaurio"), 1);
LT_END_TEST(ValorEsCorrectoTrasUnaInsercion)

LT_BEGIN_TEST(TestsEjercicio2, ClavesEsCorrectoTrasUnaInsercion)
    hM.incrementar("tiranosaurio");
    std::vector<std::string> actual = hM.claves();
    std::vector<std::string> expected = {"tiranosaurio"};
    LT_CHECK_COLLECTIONS_EQ(actual.begin(), actual.end(), expected.begin());
LT_END_TEST(ClavesEsCorrectoTrasUnaInsercion)

LT_BEGIN_TEST(TestsEjercicio2, ValorEsCorrectoTrasDosInsercionesMismaPalabra)
    hM.incrementar("tiranosaurio");
    hM.incrementar("tiranosaurio");
    LT_CHECK_EQ(hM.valor("tiranosaurio"), 2);
LT_END_TEST(ValorEsCorrectoTrasDosInsercionesMismaPalabra)

LT_BEGIN_TEST(TestsEjercicio2, ClavesEsCorrectoTrasDosInsercionesMismaPalabra)
    hM.incrementar("tiranosaurio");
    hM.incrementar("tiranosaurio");
    std::vector<std::string> actual = hM.claves();
    std::vector<std::string> expected = {"tiranosaurio"};
    LT_CHECK_COLLECTIONS_EQ(actual.begin(), actual.end(), expected.begin());
LT_END_TEST(ClavesEsCorrectoTrasDosInsercionesMismaPalabra)

LT_BEGIN_TEST(TestsEjercicio2, ValorEsCorrectoTrasVariasInsercionesMismoBucket)
    hM.incrementar("tiranosaurio");
    hM.incrementar("tiranosaurio");
    hM.incrementar("triceratops");
    LT_CHECK_EQ(hM.valor("tiranosaurio"), 2);
    LT_CHECK_EQ(hM.valor("triceratops"), 1);
LT_END_TEST(ValorEsCorrectoTrasVariasInsercionesMismoBucket)

LT_BEGIN_TEST(TestsEjercicio2, ClavesEsCorrectoTrasVariasInsercionesMismoBucket)
    hM.incrementar("tiranosaurio");
    hM.incrementar("tiranosaurio");
    hM.incrementar("triceratops");
    std::vector<std::string> actual = hM.claves();
    LT_CHECK_EQ(actual.size(), 2);
    LT_CHECK(std::find(actual.begin(), actual.end(), "tiranosaurio") != actual.end());
    LT_CHECK(std::find(actual.begin(), actual.end(), "triceratops") != actual.end());
LT_END_TEST(ClavesEsCorrectoTrasVariasInsercionesMismoBucket)

LT_BEGIN_TEST(TestsEjercicio2, ValorEsCorrectoTrasVariasInsercionesDistintoBucket)
    hM.incrementar("tiranosaurio");
    hM.incrementar("estegosaurio");
    hM.incrementar("tiranosaurio");
    LT_CHECK_EQ(hM.valor("tiranosaurio"), 2);
    LT_CHECK_EQ(hM.valor("estegosaurio"), 1);
LT_END_TEST(ValorEsCorrectoTrasVariasInsercionesDistintoBucket)

LT_BEGIN_TEST(TestsEjercicio2, ClavesEsCorrectoTrasVariasInsercionesDistintoBucket)
    hM.incrementar("tiranosaurio");
    hM.incrementar("estegosaurio");
    hM.incrementar("tiranosaurio");
    std::vector<std::string> actual = hM.claves();
    LT_CHECK_EQ(actual.size(), 2);
    LT_CHECK(std::find(actual.begin(), actual.end(), "tiranosaurio") != actual.end());
    LT_CHECK(std::find(actual.begin(), actual.end(), "estegosaurio") != actual.end());
LT_END_TEST(ClavesEsCorrectoTrasVariasInsercionesDistintoBucket)

// Tests Ejercicio 3

LT_BEGIN_SUITE(TestsEjercicio3)

HashMapConcurrente hM;

void set_up()
{
}

void tear_down()
{
}
LT_END_SUITE(TestsEjercicio3)

LT_BEGIN_TEST(TestsEjercicio3, MaximoEsCorrecto)
    hM.incrementar("tiranosaurio");
    hM.incrementar("tiranosaurio");
    hM.incrementar("tiranosaurio");
    hM.incrementar("tiranosaurio");
    hM.incrementar("estegosaurio");
    hM.incrementar("estegosaurio");

    hashMapPair actual = hM.maximo();
    LT_CHECK_EQ(actual.first, "tiranosaurio");
    LT_CHECK_EQ(actual.second, 4);
LT_END_TEST(MaximoEsCorrecto)

LT_BEGIN_TEST(TestsEjercicio3, MaximoParaleloEsCorrectoUnThread)
    hM.incrementar("tiranosaurio");
    hM.incrementar("tiranosaurio");
    hM.incrementar("tiranosaurio");
    hM.incrementar("tiranosaurio");
    hM.incrementar("estegosaurio");
    hM.incrementar("estegosaurio");

    hashMapPair actual = hM.maximoParalelo(1);
    LT_CHECK_EQ(actual.first, "tiranosaurio");
    LT_CHECK_EQ(actual.second, 4);
LT_END_TEST(MaximoParaleloEsCorrectoUnThread)

LT_BEGIN_TEST(TestsEjercicio3, MaximoParaleloEsCorrectoDosThreads)
    hM.incrementar("tiranosaurio");
    hM.incrementar("tiranosaurio");
    hM.incrementar("tiranosaurio");
    hM.incrementar("tiranosaurio");
    hM.incrementar("estegosaurio");
    hM.incrementar("estegosaurio");

    hashMapPair actual = hM.maximoParalelo(2);
    LT_CHECK_EQ(actual.first, "tiranosaurio");
    LT_CHECK_EQ(actual.second, 4);
LT_END_TEST(MaximoParaleloEsCorrectoDosThreads)

// Tests Ejercicio 4

LT_BEGIN_SUITE(TestsEjercicio4)

HashMapConcurrente hM;

void set_up()
{
}

void tear_down()
{
}
LT_END_SUITE(TestsEjercicio4)

LT_BEGIN_TEST(TestsEjercicio4, CargarArchivoFunciona)
    cargarArchivo(hM, "data/test-1");
    LT_CHECK_EQ(hM.valor("tiranosaurio"), 1);
    LT_CHECK_EQ(hM.claves().size(), 5);
LT_END_TEST(CargarArchivoFunciona)

LT_BEGIN_TEST(TestsEjercicio4, CargarMultiplesArchivosFuncionaUnThread)
    cargarMultiplesArchivos(hM, 1, {"data/test-1", "data/test-2", "data/test-3"});
    LT_CHECK_EQ(hM.valor("tiranosaurio"), 2);
    LT_CHECK_EQ(hM.valor("linux"), 3);
    LT_CHECK_EQ(hM.valor("estegosaurio"), 4);
    LT_CHECK_EQ(hM.claves().size(), 12);
LT_END_TEST(CargarMultiplesArchivosFuncionaUnThread)

LT_BEGIN_TEST(TestsEjercicio4, CargarMultiplesArchivosFuncionaDosThreads)
    cargarMultiplesArchivos(hM, 2, {"data/test-1", "data/test-2", "data/test-3"});
    LT_CHECK_EQ(hM.valor("tiranosaurio"), 2);
    LT_CHECK_EQ(hM.valor("linux"), 3);
    LT_CHECK_EQ(hM.valor("estegosaurio"), 4);
    LT_CHECK_EQ(hM.claves().size(), 12);
LT_END_TEST(CargarMultiplesArchivosFuncionaDosThreads)

LT_BEGIN_SUITE(TestsConcurrencia) 

const unsigned int THREADS = 16;
HashMapConcurrente hM;
std::vector<std::string> A;

void set_up() {
    HashMapConcurrente hM;
    cargarArchivo(hM, "data/animales");
    A = hM.claves();
}

void tear_down() {
}

LT_END_SUITE(TestsConcurrencia)

LT_BEGIN_TEST(TestsConcurrencia, LongitudListaAtomica)
    enum Animales {Oveja, Lobo};
    ListaAtomica<Animales> animales;

    const unsigned int n = 100;
    std::vector<std::thread> threads(THREADS);
    animales.insertar(Oveja);
    for (auto &t : threads)
        t = std::thread([&](){
            for (size_t i = 0; i < n; ++i)
                animales.insertar(Lobo);
        });
    for (auto &t : threads)
        t.join();
    LT_CHECK_EQ(animales.longitud(), THREADS * n + 1);
    bool count = true;
    for (size_t i = 0; i < THREADS * n; ++i)
        count &= (animales[i] == Lobo);
    count &= (animales[THREADS * n] == Oveja);
    LT_CHECK_EQ(count, true);
LT_END_TEST(LongitudListaAtomica)

LT_BEGIN_TEST(TestsConcurrencia, ColisionHashMap)
    std::vector<std::string> animales_con_o;
    std::copy_if(A.begin(), A.end(), std::back_inserter(animales_con_o), [](std::string s){return s[0] == 'o';});
    HashMapConcurrente hM;

    const unsigned int n = 1024;
    std::vector<std::thread> threads(THREADS);
    for (size_t i = 0; i < THREADS; ++i)
        threads[i] = std::thread([&hM, &animales_con_o, i]() {
            std::string word = animales_con_o[i%8];
            for (size_t j = 0; j < n; ++j)
                hM.incrementar(word);
        });
    for (auto &t : threads)
        t.join();

    auto claves = hM.claves();
    std::set<std::string> expected(animales_con_o.begin(), animales_con_o.end());
    bool count = true;
    bool keys  = true;
    for(auto it = claves.begin(); it != claves.end(); ++it) {
        count &= (hM.valor(*it) == n*2);
        keys  &= (expected.find(*it) != expected.end());
    }
    LT_CHECK_EQ(count, true);
    LT_CHECK_EQ(keys , true);
LT_END_TEST(ColisionHashMap)

LT_BEGIN_TEST(TestsConcurrencia, IncrementarHashMap)
    std::vector<std::string> animales = A;
    HashMapConcurrente hM;
    
    const unsigned int n = 1024;
    std::vector<std::thread> threads(THREADS);
    for (size_t i = 0; i < THREADS; ++i)
        threads[i] = std::thread([&hM, &animales, i]() {
            std::string word = animales[i];
            for (size_t j = 0; j < n; ++j)
                hM.incrementar(word);
        });
    for (auto &t : threads)
        t.join();

    auto claves = hM.claves();
    std::set<std::string> expected(A.begin(), A.end());
    bool count = true;
    bool keys  = true;
    for(auto it = claves.begin(); it != claves.end(); ++it) {
        count &= (hM.valor(*it) == n);
        keys  &= (std::find(expected.begin(), expected.end(), *it) != expected.end());
    }
    LT_CHECK_EQ(count, true);
    LT_CHECK_EQ(keys , true);

LT_END_TEST(IncrementarHashMap)

LT_BEGIN_TEST(TestsConcurrencia, ClavesHashMap)
    std::vector<std::string> animales = A;
    HashMapConcurrente hM;

    const unsigned int n = 5;
    std::vector<std::thread> threads(THREADS);
    for (size_t i = 0; i < THREADS; ++i)
        threads[i] = std::thread([&hM, &animales, i]() {
            std::string word = animales[i];
            for (size_t j = 0; j < n; ++j)
                hM.incrementar(word);
        });
    for (auto &t : threads)
        t.join();

    std::set<std::string> expected(A.begin(), A.end());

    auto claves = hM.claves();
    std::set<std::string> set_claves(claves.begin(), claves.end());
    bool EQ = true;
    for (std::string s : set_claves)
        EQ &= (expected.count(s) > 0);
    LT_CHECK_EQ(EQ, true);
    
LT_END_TEST(ClavesHashMap)

LT_BEGIN_TEST(TestsConcurrencia, MaximoHashMap)
    std::vector<std::string> animales = animales;
    HashMapConcurrente hM;

    const unsigned int n = 5;
    std::vector<std::thread> threads(THREADS);
    for (size_t i = 0; i < THREADS; ++i)
        threads[i] = std::thread([&hM, &animales, i]() {
            std::string word = animales[std::rand() % 16];
            for (size_t j = 0; j < n; ++j)
                hM.incrementar(word);
        });
    for (auto &t : threads)
        t.join();

    for(size_t i = 0; i < n*THREADS + 1; ++i)
        hM.incrementar("pejelagarto");
    
    hashMapPair max = hM.maximoParalelo(THREADS);
    LT_ASSERT_EQ(max.first, "pejelagarto");
    LT_ASSERT_EQ(max.second, n * THREADS + 1);
    
LT_END_TEST(MaximoHashMap)

LT_BEGIN_TEST(TestsConcurrencia, CargarMultiplesArchivos)
    cargarMultiplesArchivos(hM, 8, {
        "data/test-2", "data/test-2", "data/test-2", "data/test-2", "data/test-2", "data/test-2", "data/test-2", "data/test-2",
        "data/test-2", "data/test-2", "data/test-2", "data/test-2", "data/test-2", "data/test-2", "data/test-2", "data/test-2"});
    LT_CHECK_EQ(hM.valor("windows"), 2*16);
    LT_CHECK_EQ(hM.valor("linux"), 3*16);
    LT_CHECK_EQ(hM.valor("android"), 16);
    LT_CHECK_EQ(hM.valor("bsd"), 16);
    LT_CHECK_EQ(hM.valor("macos"), 16);
    LT_CHECK_EQ(hM.claves().size(), 5);
LT_END_TEST(CargarMultiplesArchivos)

// Ejecutar tests
LT_BEGIN_AUTO_TEST_ENV()
    AUTORUN_TESTS()
LT_END_AUTO_TEST_ENV()