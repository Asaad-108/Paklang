%{
#include <stdio.h>

int line = 1;
FILE *tFout;         
FILE *eFout;         
FILE *yyin;          
%}

%option noyywrap

%%

[ \t]+                ;
\n                    { line++; }

"agar"|"warna"|"jab"|"dobarah"|"wapis"|"karo"|"chalo"|"ruko"|"sach"|"jhoot"|"likho"|"riyazi"|"angerazi"|"poucho"|"HanYahNah" { fprintf(tFout, "Line %d: KEYWORD -> %s\n", line, yytext); }

"=="|"="|"+"|"-"|"*"|"/" { fprintf(tFout, "Line %d: OPERATOR -> %s\n", line, yytext); }

"("|")"|"{"|"}"|","|";"  { fprintf(tFout, "Line %d: PUNCTUATION -> %s\n", line, yytext); }

[0-9]+\.[0-9]+        { fprintf(tFout, "Line %d: DECIMAL -> %s\n", line, yytext); }
[0-9]+                { fprintf(tFout, "Line %d: NUMBER -> %s\n", line, yytext); }

\"([^\"\\]|\\.)*\"     { fprintf(tFout, "Line %d: STRING -> %s\n", line, yytext); }

[A-Za-z_][A-Za-z0-9_]* { fprintf(tFout, "Line %d: IDENTIFIER -> %s\n", line, yytext); }

.                     {fprintf(tFout, "Line %d: ERROR -> %s\n", line, yytext);
fprintf(eFout, "Line %d: ERROR -> %s\n", line, yytext);}

%%

int main() {

    yyin = fopen("input.txt", "r");
    if (!yyin) {
        printf("Error opening input.txt\n");
        return 1;
    }

    tFout = fopen("tokens.txt", "w");
    if (!tFout) {
        printf("Error opening tokens.txt\n");
        fclose(yyin);
        return 1;
    }

    eFout = fopen("errors.txt", "w");
    if (!eFout) {
        printf("Error opening errors.txt\n");
        fclose(yyin);
        fclose(tFout);
        return 1;
    }

    yylex();

    fclose(tFout);
    fclose(eFout);
    fclose(yyin);

    return 0;
}
