%{
#include <stdio.h>
FILE *errFile;

int yylex();
void yyerror(const char *s);
%}

%union {
    int num;
}

%token RIYAZI ANGERAZI BOOL
%token AGAR WARNA DOBARAH LIKHO
%token ID
%token <num> NUMBER

%%

Program :
    StmtList
    {
        printf("Parsing completed.\n");
    }
;

StmtList :
      Stmt StmtList
    | /* empty */
;

Stmt :
      DeclStmt
    | AssignStmt
    | IfStmt
    | LoopStmt
    | PrintStmt
    | error ';'   { yyerrok }
;

DeclStmt :
    RIYAZI ID ';'
  | ANGERAZI ID ';'
  | BOOL ID ';'
;

AssignStmt :
    ID '=' Expr ';'
;

IfStmt :
    AGAR '(' Expr ')' '{' StmtList '}' WARNA '{' StmtList '}'
;

LoopStmt :
    DOBARAH '(' Expr ')' '{' StmtList '}'
;

PrintStmt :
    LIKHO '(' Expr ')' ';'
;

Expr :
      Expr '+' Expr
    | Expr '-' Expr
    | Expr '*' Expr
    | Expr '/' Expr
    | NUMBER
    | ID
;

%%

void yyerror(const char *s) {
    fprintf(errFile, "%s\n", s);
    printf("%s\n", s);
}

int main() {

    errFile = fopen("error.txt", "w");
    if (!errFile) {
        printf("Cannot open error.txt\n");
        return 1;
    }

    yyparse();

    fclose(errFile);
    return 0;
}
