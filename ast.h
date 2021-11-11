#ifndef _AST_H_
#define _AST_H_

#include <list>
#include <string>

using namespace std;

class Statement;
class InitDeclarator;

typedef list<string *> VariablesList;

class Statement{
    public:
        int line;
};

class Declaration{
    public:
        int line;

};

class InitDeclarator{
    public:
        int line;

};

class ListVariables{
    public:
        char * variable;

};



#endif
