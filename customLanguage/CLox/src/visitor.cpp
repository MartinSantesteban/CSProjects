#include "./visitor.h"

string Visitor::visitBinary(Binary& e){return "";}

string Visitor::visitGrouping(Grouping& e){return "";}

string Visitor::visitLiteral(Literal& e){return "";}

string Visitor::visitUnary(Unary& e){return "";}

string Printer::visitBinary(Binary& e){
       string s = e.op->lexeme + " (" + (*e.left).visit(*this) + ") (" + (*e.right).visit(*this) + ") ";    
       return s;
}

string Printer::visitGrouping(Grouping& e){
       string s = "group " + (*e.expression).visit(*this);
       return s;
}

string Printer::visitLiteral(Literal& e){
       string s = e.value;
       return s;
}

string Printer::visitUnary(Unary& e){
       string s = e.op->lexeme + (*e.right).visit(*this);
       return s;
}
