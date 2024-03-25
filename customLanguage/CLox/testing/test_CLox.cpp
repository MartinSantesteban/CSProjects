#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include "doctest.h"
#include "../src/CLox.cpp"

TEST_CASE("Testing: Lexer using valid/invalid parameters") {
	CLox cl;
	const char* p1 = "testing/prueba_input_lexer";
	const char* p2 = "otra cosa";

	//const char* parameters0[] = {};	No puedo hacer tdd sobre el repl todavia
    //CHECK(cl.scan(sizeof(parameters0)/sizeof(parameters0[0]) ,parameters0) == 0);
	
	const char* parameters1[] = {p1};
    CHECK(cl.scan(sizeof(parameters1)/sizeof(parameters1[1]) ,parameters1) == 0);

	const char* parameters2[] = {p1,p2};
    CHECK(cl.scan(sizeof(parameters2)/sizeof(parameters2[0]) ,parameters2) == -1);
}

TEST_CASE("Testing: Compiler starts without error."){
	CLox cl;
	CHECK(!cl.codeHadError());
}

TEST_CASE("Testing: Compiler throws correct error && switches hadError"){
	CLox cl;
	CHECK(cl.error(1,"error trial") == "[line 1] Error: error trial");
	CHECK(cl.codeHadError());
}

