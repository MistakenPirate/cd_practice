%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char* s);
int yylex();
%}

%token NUMBER PLUS MINUS MULT DIV EOL LPAREN RPAREN

%left PLUS MINUS
%left MULT DIV

// PLUS and MINUS are left-associative with lower precedence.
// MULT and DIV are left-associative with higher precedence than PLUS and MINUS.

%%
input:
    /* empty */
  | input line
  ;

line:
    expr EOL        { printf("= %d\n", $1); }
  ;

expr:
    expr PLUS expr  { $$ = $1 + $3; }
  | expr MINUS expr { $$ = $1 - $3; }
  | expr MULT expr  { $$ = $1 * $3; }
  | expr DIV expr   {
                      if ($3 == 0) {
                          yyerror("Division by zero");
                          $$ = 0;
                      } else {
                          $$ = $1 / $3;
                      }
                    }
  | LPAREN expr RPAREN { $$ = $2; }
  | NUMBER          { $$ = $1; }
  ;
%%

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter expressions (Ctrl+D to exit):\n");
    yyparse();
    return 0;
}
