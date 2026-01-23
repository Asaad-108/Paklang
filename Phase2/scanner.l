%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
int lineNo = 1;
%}

%option noyywrap

%%

[ \t]+          ;
\n              { lineNo++; }

"riyazi"        { return RIYAZI; }
"angerazi"      { return ANGERAZI; }
"HanYahNah"     { return BOOL; }

"agar"          { return AGAR; }
"warna"         { return WARNA; }
"dobarah"       { return DOBARAH; }
"likho"         { return LIKHO; }

[0-9]+          { yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { return ID; }

"=="|"="|"+"|"-"|"*"|"/"  { return yytext[0]; }

"("             { return '('; }
")"             { return ')'; }
"{"             { return '{'; }
"}"             { return '}'; }
";"             { return ';'; }

. {
    printf("Lexical Error at line %d: %s\n", lineNo, yytext);
}

%%
