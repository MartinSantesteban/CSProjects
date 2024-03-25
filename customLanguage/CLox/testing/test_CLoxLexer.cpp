#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include "doctest.h"
#include "../src/CLoxLexer.cpp"

TEST_CASE("Testing: Correct tokenization of single character tokens"){

	CLoxLexer lex("                                ");
	CHECK(lex.scan() == vector<Token>());

	lex = CLoxLexer("(");
	CHECK(lex.scan() == vector<Token>(1,{Token(L_PAREN, "(", 0)}));

	CLoxLexer lex2("(){}+-*/,;.\n");
	vector<Token> vect2{Token(L_PAREN, "(", 0),
						Token(R_PAREN, ")", 0),
						Token(L_BRACE, "{", 0),
						Token(R_BRACE, "}", 0),
						Token(PLUS, "+", 0),
						Token(MINUS, "-", 0),
						Token(STAR, "*", 0),
						Token(SLASH, "/", 0),
						Token(COMMA, ",", 0),
						Token(SEMICOLON, ";", 0),
						Token(DOT, ".", 0),
						Token(END_OF_LINE, "/n", 0)};
	CHECK(lex2.scan() == vect2);

	CLoxLexer lex3("(\n)\n{\n}\n+\n-\n*\n/\n,\n;\n.\n");
	vector<Token> vect3{Token(L_PAREN, "(", 0),Token(END_OF_LINE, "/n", 0),
						Token(R_PAREN, ")", 1),Token(END_OF_LINE, "/n", 1),
						Token(L_BRACE, "{", 2),Token(END_OF_LINE, "/n", 2),
						Token(R_BRACE, "}", 3),Token(END_OF_LINE, "/n", 3),
						Token(PLUS, "+", 4),Token(END_OF_LINE, "/n", 4),
						Token(MINUS, "-", 5),Token(END_OF_LINE, "/n", 5),
						Token(STAR, "*", 6),Token(END_OF_LINE, "/n", 6),
						Token(SLASH, "/", 7),Token(END_OF_LINE, "/n", 7),
						Token(COMMA, ",", 8),Token(END_OF_LINE, "/n", 8),
						Token(SEMICOLON, ";", 9),Token(END_OF_LINE, "/n", 9),
						Token(DOT, ".", 10),Token(END_OF_LINE, "/n", 10)};
	CHECK(lex3.scan() == vect3);
}

TEST_CASE("Testing: Correct tokenization of single dependant && double tokens"){
	CLoxLexer lex("!");
	CHECK(lex.scan() == vector<Token>(1,{Token(BANG, "!", 0)}));

	lex = CLoxLexer("!=");
	CHECK(lex.scan() == vector<Token>(1,{Token(BANG_EQUAL, "!=", 0)}));

	lex = CLoxLexer("<");
	CHECK(lex.scan() == vector<Token>(1,{Token(LESS, "<", 0)}));

	lex = CLoxLexer("<=");
	CHECK(lex.scan() == vector<Token>(1,{Token(LESS_EQUAL, "<=", 0)}));

	lex = CLoxLexer(">");
	CHECK(lex.scan() == vector<Token>(1,{Token(GREATER, ">", 0)}));

	lex = CLoxLexer(">=");
	CHECK(lex.scan() == vector<Token>(1,{Token(GREATER_EQUAL, ">=", 0)}));

	lex = CLoxLexer(">\n<=\n!!!=");
	vector<Token> vect{Token(GREATER, ">", 0) , Token(END_OF_LINE, "/n", 0), Token(LESS_EQUAL, "<=", 1), Token(END_OF_LINE, "/n", 1),Token(BANG, "!", 2)
					   ,Token(BANG, "!", 2),Token(BANG_EQUAL, "!=", 2)};
	CHECK(lex.scan() == vect);

	lex = CLoxLexer("> <= ! ! !=");
	vector<Token> vect2{Token(GREATER, ">", 0), Token(LESS_EQUAL, "<=", 0), Token(BANG, "!", 0)
					   ,Token(BANG, "!", 0),Token(BANG_EQUAL, "!=", 0)};
	CHECK(lex.scan() == vect2);
}

TEST_CASE("Testing: Correct tokenization of literals"){
	CLoxLexer lex("\"\"");
	CHECK(lex.scan() == vector<Token>(1,{Token(STRING, "\"\"", 0)}));	

	lex = CLoxLexer("\"Hola como estas?\"");
	CHECK(lex.scan() == vector<Token>(1,{Token(STRING, "\"Hola como estas?\"", 0)}));

	lex = CLoxLexer("\"0\"");
	CHECK(lex.scan() == vector<Token>(1,{Token(STRING, "\"0\"", 0)}));

	lex = CLoxLexer("0");
	CHECK(lex.scan() == vector<Token>(1,{Token(NUMBER, "0", 0)}));
	
	lex = CLoxLexer("000012364");
	CHECK(lex.scan() == vector<Token>(1,{Token(NUMBER, "12364", 0)}));

	lex = CLoxLexer("000012030640");
	CHECK(lex.scan() == vector<Token>(1,{Token(NUMBER, "12030640", 0)}));

	lex = CLoxLexer("000012030.64");
	CHECK(lex.scan() == vector<Token>(1,{Token(NUMBER, "12030.64", 0)}));

	lex = CLoxLexer("000012030.640000");
	CHECK(lex.scan() == vector<Token>(1,{Token(NUMBER, "12030.64", 0)}));

	lex = CLoxLexer("000012030.640000*+\n\"HolaComoEstas\"53");
	vector<Token> vect{Token(NUMBER, "12030.64", 0),
										 Token(STAR, "*", 0),
										 Token(PLUS, "+", 0),
										 Token(END_OF_LINE, "/n", 0),
										 Token(STRING, "\"HolaComoEstas\"", 1),
										 Token(NUMBER, "53", 1)};
	CHECK(lex.scan() == vect);

	lex = CLoxLexer("000012030.640000 + 53");
	vector<Token> vect2{Token(NUMBER, "12030.64", 0),
										 Token(PLUS, "+", 0),
										 Token(NUMBER, "53", 0)};
	CHECK(lex.scan() == vect2);

}

TEST_CASE("Testing: Correct tokenization of keywords"){
	for(auto u: keywords){
		CLoxLexer lex(u.first);
		CHECK(lex.scan() == vector<Token>(1,{Token(keywords.at(u.first), u.first , 0)}));	
	}
	
	CLoxLexer lex("forwhileclasssuper");
	CHECK(lex.scan() == vector<Token>(1,{Token(IDENTIFIER, "forwhileclasssuper" , 0)}));	

	lex = CLoxLexer("for while class super");
	vector<Token> vect = {Token(FOR, "for" , 0), Token(WHILE, "while" , 0), Token(CLASS, "class" , 0), Token(SUPER, "super" , 0)};	
	CHECK(lex.scan() == vect);
}

TEST_CASE("Testing: Correct tokenization of script."){
	CLoxLexer lex("var i1 = 4;\nfun suma(a, b){\nreturn a + b;\n}");
	vector<Token> vect = {Token(VAR, "var" , 0), Token(IDENTIFIER, "i1" , 0), Token(EQUAL, "=" , 0), Token(NUMBER, "4" , 0),Token(SEMICOLON, ";", 0), Token(END_OF_LINE, "/n", 0),
						  Token(FUN, "fun", 1),Token(IDENTIFIER, "suma", 1),Token(L_PAREN, "(", 1),Token(IDENTIFIER, "a", 1), Token(COMMA, ",", 1),Token(IDENTIFIER, "b", 1),Token(R_PAREN, ")", 1), Token(L_BRACE, "{", 1), Token(END_OF_LINE, "/n", 1),
						  Token(RETURN, "return", 2),Token(IDENTIFIER, "a", 2),Token(PLUS, "+", 2),Token(IDENTIFIER, "b", 2),Token(SEMICOLON, ";", 2),Token(END_OF_LINE, "/n", 2),
						  Token(R_BRACE, "}", 3)};	
	CHECK(lex.scan() == vect);
}
