main: src/main.cpp
	g++ -o ./bin/main ./src/main.cpp 
	./bin/main

test: testing/test_CLox.cpp testing/test_CLoxLexer.cpp
	g++ -o ./bin/test_CLox ./testing/test_CLox.cpp
	g++ -o ./bin/test_CLoxLexer ./testing/test_CLoxLexer.cpp
	./bin/test_CLox
	./bin/test_CLoxLexer

test_CLox: testing/test_CLox.cpp
	g++ -o ./bin/test_CLox ./testing/test_CLox.cpp
	./bin/test_CLox

test_CLoxLexer: testing/test_CLoxLexer.cpp
	g++ -o ./bin/test_CLoxLexer ./testing/test_CLoxLexer.cpp
	./bin/test_CLoxLexer

AST: src/AST.cpp
	g++ -o ./bin/ast ./src/AST.cpp
	

