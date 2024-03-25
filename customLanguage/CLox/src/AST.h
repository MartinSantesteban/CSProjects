#include "./CLoxLexer.cpp"

class Visitor; //forward declaration

class Expr{
    public:
    virtual string visit(Visitor& v);
};

class Binary : public Expr{
    public:
        Binary(Expr *left,Token *op,Expr *right);
        Expr* left;
        Token* op;
        Expr* right;
        string visit(Visitor& v);
};

class Grouping : public Expr{
    public:
        Grouping(Expr *expression);
        Expr* expression;
        string visit(Visitor& v);
};

class Literal : public Expr{
    public:
        Literal(string& value);
        string value;
        string visit(Visitor& v);
};

class Unary : public Expr{
    public:
        Unary(Token *op,Expr *right);
        Token* op;
        Expr* right;
        string visit(Visitor& v);
};

