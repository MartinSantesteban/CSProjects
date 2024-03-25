class Visitor{
public:
       virtual string visitBinary(Binary& e);
       virtual string visitGrouping(Grouping& e);
       virtual string visitLiteral(Literal& e);
       virtual string visitUnary(Unary& e);
};

class Printer : public Visitor{
public:      
       string visitBinary(Binary& e);
       string visitGrouping(Grouping& e);
       string visitLiteral(Literal& e);
       string visitUnary(Unary& e);
};