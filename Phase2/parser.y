%{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
%}

%union {
    int num;
}

%token RIYAZI ANGERAZI BOOL
%token AGAR WARNA DOBARAH LIKHO
%token ID NUMBER

%%

Program :
    StmtList
    { printf("Syntax analysis successful!\n"); }
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
    printf("Syntax Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
