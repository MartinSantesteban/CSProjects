#include<iostream>
#include<cstdlib>
#include<sstream>
#include<fstream>
#include<vector>
#include "./CLoxLexer.cpp"
using namespace std;

class CLox {
	public:
		int scan(int argc, const char *args[]){
			if(argc > 1){
				// este cout tiene sentido cuando tengamos el main andando.
				cout << "USAGE: clox <path of lox sourcefile>" << endl; 
				return -1;
			}else if(argc == 1){
				return runFile(args[0]);
			}else{
				return runPrompt();
			}
		}		

		bool codeHadError(){
			return hadError;
		}

		string error(int line, string message){ // este se volvio public solo para poder testear
			return report(line, "", message);
		}

	private:
		int runFile(const char *filepath){
			//auto *file = fopen(filepath, "r");
			ifstream o(filepath);
			if(o.fail()){
				cout << "File not in directory!" << endl;
				return -1;
			}
			stringstream strStream;
			strStream << o.rdbuf();
			run(strStream.str());
			if(hadError) return -1;
			return 0;
		}

		int runPrompt(){
			//REPL = Read line of Input - Evaluate - Print - Loop
			string input; 
			while(true){
				cout << ">> " ;
				cin >> input;
				run(input);
				cout << endl;
				if(input == ":q" ){
					cout << "Exiting clox" << endl;
					break;
				}
				hadError = false;
			}
			return 0;
		}

		void run(string src){
			CLoxLexer l(src);
			vector<Token> tokens = l.scan();
			for(Token t : tokens){
				cout << t << endl;
			}
		}


		string report(int line, string where, string message){
			string res = "[line " + to_string(line) + "] Error" + where + ": " + message;
			cout << res << endl;
			this->hadError = true;
			return res;
		}


		bool hadError = false;
};
