#include "./AST.cpp"
#include <iostream>
using namespace std;

int main(){
	Token t(PLUS, "+", 0);
	string var = "5";
	Literal l(var);
	Binary b(&l,&t,&l);
	Grouping g(&b);
	Binary b2(&g, &t, &l);
	Printer p;
	//cout << b.visit(p) << endl;
	cout << b2.visit(p) << endl;    
	return 0;
}
