%{
#include <stdio.h>
int line = 1;
%}

%option noyywrap

%%

[ \t]+                ;
\n                    { line++; }

"agar"|"warna"|"jab"|"dobarah"|"wapis"|"karo"|"chalo"|"ruko"|"sach"|"jhoot"|"likho"|"riyazi"|"angerazi"|"poucho"|"HanYahNah" { printf("Line %d: KEYWORD -> %s\n", line, yytext); }

"=="|"="|"+"|"-"|"*"|"/" { printf("Line %d: OPERATOR -> %s\n", line, yytext); }

"("|")"|"{"|"}"|","|";" { printf("Line %d: PUNCTUATION -> %s\n", line, yytext); }

[0-9]+\.[0-9]+        { printf("Line %d: DECIMAL -> %s\n", line, yytext); }
[0-9]+                { printf("Line %d: NUMBER -> %s\n", line, yytext); }

\"([^\"\\]|\\.)*\"     { printf("Line %d: STRING -> %s\n", line, yytext); }

[A-Za-z_][A-Za-z0-9_]* { printf("Line %d: IDENTIFIER -> %s\n", line, yytext); }

.                     { printf("Line %d: ERROR -> %s\n", line, yytext); }

%%

int main(void) {
    yylex();
    return 0;
}


