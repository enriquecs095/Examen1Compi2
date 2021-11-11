%option noyywrap
%option yylineno
%option caseless

%{
    #include "tokens.h"
      #include <stdio.h>
%}

DIGIT [0-9]

%%
"+" { return ADD; }
"=" { return '='; }
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }
"(" { return '('; }
")" { return ')'; }
"," { return ','; }
";" {  }
">" { return '>'; }
"<" { return '<'; }
"let" { return LET; }
"while" { return WHILE; }
"do" { return DO; }
"done" { return DONE; }
{DIGIT}+"."{DIGIT}+ { yylval.float_t = atof(yytext); return FLOAT; }
{DIGIT}+ { yylval.float_t = atof(yytext); return FLOAT; }
[a-zA-Z]({DIGIT}|[a-zA-Z_0-9]|_)* { yylval.string_t = strdup(yytext); return TK_ID; }
[\n] {}
[\t \r ] { /* ignorar */ }
. { printf("invalido %c\n", yytext[0]); }

%%