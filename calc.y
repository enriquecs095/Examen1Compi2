%code requires{
    #include "ast.h"
    #include <list>
}

%{

    #include <cstdio>
    using namespace std;
    int yylex();
    extern int yylineno;
    void yyerror(const char * s){
        fprintf(stderr, "Line: %d, error: %s\n", yylineno, s);
    }

       #define YYERROR_VERBOSE 1
    #define YYDEBUG 1
    #define EQUAL 1
    #define PLUSEQUAL 2
    #define MINUSEQUAL 3

%}

%union{
    const char * string_t;
    float float_t;
    Statement * statement_t;
    Declaration * declaration_t;
    InitDeclarator * init_declarator_t;
    VariablesList * list_variables_t;
    VariablesList * variable_list_t;
}


%token<string_t> TK_ID
%token<float_t> FLOAT
%type<float_t> constant
%type<string_t> declarator parameter_declaration
%type<list_variables_t> method_definition
%type<statement_t>   external_declaration declaration  expression_list statement while_statement parameters_type_list
%type<float_t>  relational_expression add_sub multi_div value  
%type<init_declarator_t> input
%token EOL
%token LET ADD SUB MUL DIV WHILE DO DONE  

%%
     
input: 
    | input relational_expression   
    | input external_declaration   
    ;

external_declaration: method_definition  
            | declaration
            | relational_expression 
            ;

declaration: LET TK_ID '=' constant  {  printf("Variable %s declarada\n", $2 );   }
            | TK_ID '(' parameters_type_list ')'    
           ; 

constant: FLOAT {$$=$1;}
        ;

method_definition: LET TK_ID '(' parameters_type_list ')' '=' expression_list  { printf("Metodo %s agregado\n", $2 ); }
                ;

expression_list: expression_list ';' statement   
                | statement 
                ;

statement: while_statement  
        | relational_expression  
        ;

while_statement: WHILE '(' relational_expression ')' DO statement DONE  
                ;

parameters_type_list: parameters_type_list ',' parameter_declaration  
                   | parameter_declaration
                   ;

parameter_declaration: declarator  {$$=$1;}
                    ;

declarator: TK_ID   {$$=$1;}
          ;

relational_expression: relational_expression '>' add_sub  
                     | relational_expression '<' add_sub  
                     | add_sub  
                     ;

add_sub: add_sub ADD multi_div { $$=$1;  printf("Resultado %.6f\n", $1 + $3 );   }
    | add_sub SUB multi_div { $$=$1;  printf("Resultado %.6f\n", $1 - $3 );   }
    | multi_div {$$=$1;}
    ;

multi_div: multi_div MUL value { $$=$1;  printf("Resultado %.6f\n", $1 * $3 );   }
    | multi_div DIV value  { $$=$1;  printf("Resultado %.6f\n", $1 / $3 );   }
    | value 
    ;

value: FLOAT { $$=$1; }
        | TK_ID 

%%

