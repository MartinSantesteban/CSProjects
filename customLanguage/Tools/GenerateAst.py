## Uso este script solo para escribir todas las clases para el AST de CLox en cpp. En lugar de escribir todas las clases behaviourless a mano, lo automatizamos.

import sys
import os

if(len(sys.argv) <= 1):   
    raise Exception("Usage: <output directory>")

outputDir = sys.argv[1]
if(not os.path.isdir(outputDir)):
    os.mkdir(outputDir)


def defineAST(outputDir, baseName, types):
    path = outputDir + "/AST.cpp"
    f = open(path, "w")
    f.write("#include \"./CLoxLexer.cpp\"\n\n")
    f.write("class " + baseName.strip() + "{\n")
    f.write("    virtual void visit(Visitor v){};\n") 
    f.write("};\n\n")
    ##defineVisitor(f, types)
    for t in types:
        className = t.split(":")[0]
        f.write("class " + className + ": public " + baseName + "{\n")
        fields = t.split(":")[1].strip()
        defineType(f, baseName, className, fields)
        f.write("};\n\n")
    

def defineType(f, baseName, className, fields):
    ##Constructor
    f.write("    public:\n")
    parameters = fields.split(",")
    parameters = [p.strip() for p in parameters]
    parameters = [p.split(" ")[0] + " &" + p.split(" ")[1] for p in parameters]
    parameters = ','.join(parameters)
    f.write("        " + className.strip() + "(" + parameters + "){\n")
    for field in fields.split(","):
        name = field.strip().split(" ")[1].strip()
        f.write("            this->" + name + " = " + name + ";\n")
    f.write("        }\n")
    f.write("    private:\n")
    for field in fields.split(","):
        f.write("        " + field.strip() + ";\n")
    f.write("        void visit(Visitor v){v.visit" + className.strip() + "(*this);}\n")
    f.write(" ")

def defineVisitor(f, types):
    f.write("class Visitor{\n")
    f.write("public:\n")
    for t in types:
        subclass = t.split(":")[0].strip()
        f.write("       void visit" + subclass + "(Expr e){}\n")
    f.write("};\n\n")


defineAST(outputDir, "Expr", ["Binary : Expr left, Token op, Expr right",
                              "Grouping : Expr expression",
                              "Literal : Object value",
                              "Unary : Token op, Expr right"]
                              )





