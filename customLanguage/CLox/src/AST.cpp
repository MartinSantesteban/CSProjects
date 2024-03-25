#include "./AST.h"
#include "./visitor.cpp"

string Expr::visit(Visitor& v){return "expr";}

Binary::Binary(Expr *left,Token *op,Expr *right){
    this->left = left;
    this->op = op;
    this->right = right;
}

string Binary::visit(Visitor& v){
    return v.visitBinary(*this);
}

Grouping::Grouping(Expr *expression){
    this->expression = expression;
}

string Grouping::visit(Visitor& v){
    return v.visitGrouping(*this);
}

Literal::Literal(string& value){
        this->value = value;
}

string Literal::visit(Visitor& v){
    return v.visitLiteral(*this);
}

Unary::Unary(Token *op,Expr *right){
    this->op = op;
    this->right = right;
}

string Unary::visit(Visitor& v){
    return v.visitUnary(*this);
}

