#include<iostream>
#include<vector>
#include<string>
#include<map>
using namespace std;

enum tokenType {
	// Single character token types (){}+-*/,;.
	L_PAREN, R_PAREN, L_BRACE, R_BRACE, PLUS, MINUS, STAR, SLASH, COMMA, SEMICOLON, DOT,
	// Two character token
	BANG, BANG_EQUAL, EQUAL, EQUAL_EQUAL, GREATER, GREATER_EQUAL, LESS, LESS_EQUAL, 
	// Literals
	IDENTIFIER, STRING, NUMBER,
	// Keywords
	AND, CLASS, ELSE, FALSE, FUN, FOR, IF, NIL, OR, PRINT, RETURN, SUPER, THIS, TRUE, VAR, WHILE, END_OF_LINE
};

string tokenTypeString[] = {
	// Single character token types (){}+-*/,;.            <- fijate que estos son independientes de todos los demas operadores
	"L_PAREN", "R_PAREN", "L_BRACE", "R_BRACE", "PLUS", "MINUS", "STAR", "SLASH", "COMMA", "SEMICOLON", "DOT",
	// Two character token types or dependant single types <- siempre que te encontras un !, tenes que chequear si el siguiente es un =. ! = no funca.
	"BANG", "BANG_EQUAL", "EQUAL", "EQUAL_EQUAL", "GREATER", "GREATER_EQUAL", "LESS", "LESS_EQUAL", 
	// Literals
	"IDENTIFIER", "STRING", "NUMBER",
	// Keywords           
	"AND", "CLASS", "ELSE", "FALSE", "FUN", "FOR", "IF", "NIL", "OR", "PRINT", "RETURN", "SUPER", "THIS", "TRUE", "VAR", "WHILE", "END_OF_LINE"
};

map<string,tokenType> keywords = {{"and", AND},{"class", CLASS},{"else", ELSE},{"false", FALSE},{"fun", FUN},{"for", FOR},{"if", IF},
								  {"nil", NIL},{"or", OR},{"print", PRINT},{"return", RETURN},{"super", SUPER},{"this", THIS},{"tre", TRUE},{"var", VAR},{"while", WHILE}};

struct Token{
	tokenType token_type; 
	string lexeme;  // el raw string del token
	int line;

	Token(tokenType tp,string lex,int l){
		this->token_type = tp;
		this->lexeme = lex;
		this->line = l;
	}

	Token(const Token &t){
		this->token_type = t.token_type;
		this->lexeme = t.lexeme;
		this->line = t.line;
	} //copy constructor

	Token() = default; //default constructor para poder pasar token como param.

	bool operator<(const Token& t) const{	
		return true;
	}

	bool operator ==(const Token& t) const{
		return (this->token_type == t.token_type && 
				this->lexeme == t.lexeme &&
				this->line == t.line);
	}

	friend ostream& operator<< (ostream &out, const Token& t){
		out << "[ " <<  tokenTypeString[t.token_type] << " | " << ((t.lexeme == "\n")? "/n" : t.lexeme) << " | " << t.line << " ]";
		return out;
	}

};

class CLoxLexer {
	public:
		CLoxLexer(string source){
			src_code = source;
		}

		vector<Token> scan(){
			while(!isAtEnd()){
				start = current;
				scanToken();
			}
			return tokens;
		}

	private:
		string src_code;
		vector<Token> tokens;
		int start = 0;
		int current = 0;
		int line = 0;

		bool isAtEnd(){
			return current == src_code.size();
		}

		void scanToken(){
			char current_char = src_code[start];
			char next_char = src_code[current+1]; 
			tokenType t;
			switch(current_char){
				case ' ':
					current++;
					break;
				case '\n':
					add_token(start, current, END_OF_LINE);
					line++;
					break;
				case '(':
					add_token(start, current, L_PAREN);
					break;
				case ')':
					add_token(start, current, R_PAREN);
					break;
				case '{':
					add_token(start, current, L_BRACE);
					break;
				case '}':
					add_token(start, current, R_BRACE);
					break;
				case '+':
					add_token(start, current, PLUS);
					break;
				case '-':
					add_token(start, current, MINUS);
					break;
				case '*':
					add_token(start, current, STAR);
					break;
				case '/':
					add_token(start, current, SLASH);
					break;
				case ',':
					add_token(start, current, COMMA);
					break;
				case ';':
					add_token(start, current, SEMICOLON);
					break;
				case '.':
					add_token(start, current, DOT);
					break;
				case '!':
					if(current != src_code.size() && next_char == '='){
						add_token(start, ++current, BANG_EQUAL); //ver si anda con current + 1
					}else{
						add_token(start, current, BANG);
					}
					break;
				case '<':
					if(current != src_code.size() && next_char == '='){
						add_token(start, ++current, LESS_EQUAL);
					}else{
						add_token(start, current, LESS);
					}
					break;
				case '>':
					if(current != src_code.size() && next_char == '='){
						add_token(start, ++current, GREATER_EQUAL);
					}else{
						add_token(start, current, GREATER);
					}
					break;
				case '=':
					if(current != src_code.size() && next_char == '='){
						add_token(start, ++current, EQUAL_EQUAL);
					}else{
						add_token(start, current, EQUAL);
					}
					break;
				case '"':
					current++;
					while(src_code[current] != '"')	current++;
					add_token(start, current, STRING);
					break;
				default:
					if(scan_number()) break;
					scan_keyword();
					break;
			}
			return;
		}

		void add_token(int start, int end, tokenType t){
			string s = src_code.substr(start, end - start + 1);
			if(t == END_OF_LINE) s = "/n"; 
			//cout << Token(t,s,line) << endl;
			tokens.push_back(Token(t,s,line));
			current++;
		}

		int scan_number(){
			bool dotted = false;
			while(current < src_code.size() && isdigit(src_code[current])) current++;
			int len = current - start;
			if(len > 0){
				if(src_code[current] == '.'){
					dotted = true;
					current++;
					while(isdigit(src_code[current])) current++;
				}
				current--;
				int aux = start;
				while(len > 1 && src_code[aux] == '0') aux++;

				int aux2 = current;
				while(len > 1 && dotted && src_code[aux2] == '0') aux2--;
				
				add_token(aux, aux2, NUMBER);
				return 1;
			}
			return 0;
		}
		
		void scan_keyword(){
			// como ya scaneaste los numeros, nunca empezas chequeando por uno de ellos.
			while(current < src_code.size() && (isalpha(src_code[current]) || isdigit(src_code[current]))) current++;
			current--;
			string lexeme = src_code.substr(start, current - start + 1);
			// 	cout << lexeme << endl;
			if(auto f = keywords.find(lexeme); f != keywords.end()){
				add_token(start, current, keywords.at(lexeme));
			}else{
				add_token(start, current, IDENTIFIER);
			}
			return;
		}
};
